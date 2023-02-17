class DiscussionsController < ApplicationController
  before_action :set_discussion, only: %i[show edit update destroy]
  def index
    @discussions = Discussion.all
  end

  def new
    @discussion = Discussion.new
    @discussion.posts.new
  end

  def create
    @discussion = Discussion.new(discussion_params)
    if @discussion.save
      redirect_to @discussion, notice: 'Discussion was created successfully'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @posts = @discussion.posts.all.order(created_at: :asc)
    @new_post = @discussion.posts.new
  end

  def edit; end

  def update
    if @discussion.update(discussion_params)
      @discussion.broadcast_replace(partial: 'discussions/show_top', locals: { discussion: @discussion })
      redirect_to @discussion, notice: 'Discussion was updated successfully'
    else
      render :edit, status: :unprocessable_entity
    end

    if @discussion.category_previously_changed?

      old_category_id, new_category_id = @discussion.category_id_previous_change
      old_category = Category.find(old_category_id)
      new_category = Category.find(new_category_id)

      # remove it from the old category list / insert to new list
      @discussion.broadcast_remove_to(old_category)
      @discussion.broadcast_prepend_to(new_category)

      # Update categories by replacing them. This updates the counters in the sidebar.
      old_category.reload.broadcast_replace_to('categories')
      new_category.reload.broadcast_replace_to('categories')
    end

    if @discussion.closed_previously_changed?
      @discussion.broadcast_action_to(
        @discussion,
        action: :replace,
        target: "new_post_form",
        partial: 'discussions/posts/form',
        locals: { post: @discussion.posts.new }
      )
    end
  end

  def destroy
    @discussion.destroy
    redirect_to discussions_path, notice: 'Discussion was deleted successfully'
  end

  private

  def discussion_params
    params.require(:discussion).permit(:title, :category_id, :pinned, :closed, posts_attributes: :body)
  end

  def set_discussion
    @discussion = Discussion.find(params[:id])
  end
end

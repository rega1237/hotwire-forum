class DiscussionsController < ApplicationController
  before_action :set_discussion, only: %i[show edit update destroy]
  def index
    @pagy, @discussions = pagy(Discussion.all.order(pinned: :desc, created_at: :desc))
  end

  def new
    authorize! :create, Discussion
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
    @pagy, @posts = pagy(@discussion.posts.all.order(created_at: :asc))
    @new_post = @discussion.posts.new
  end

  def edit
    authorize! :edit, @discussion
  end

  def update
    if @discussion.update(discussion_params)
      BroadcastDiscussion.new(@discussion).broadcast_discussion
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    authorize! :destroy, @discussion
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

class DiscussionsController < ApplicationController
  before_action :set_discussion, only: [:show, :edit, :update, :destroy]
  def index
    @discussions = Discussion.all
  end

  def new
    @discussion = Discussion.new
  end

  def create
    @discussion = Discussion.new(discussion_params)
    @discussion.user = current_user
    if @discussion.save
      redirect_to @discussion, notice: "Discussion was created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @discussion.update(discussion_params)
      @discussion.broadcast_replace(partial: "discussions/show_top", locals: { discussion: @discussion })
      redirect_to @discussion, notice: "Discussion was updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @discussion.destroy
    redirect_to discussions_path, notice: "Discussion was deleted successfully"
  end

  private

  def discussion_params
    params.require(:discussion).permit(:title, :pinned, :closed)
  end

  def set_discussion
    @discussion = Discussion.find(params[:id])
  end
end

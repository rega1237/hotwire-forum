class Discussions::Posts::RepliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    puts reply_params.inspect
    @reply = @post.replies.new(reply_params)

    if @reply.save
      redirect_to @post.discussion, notice: 'Your reply was created successfully.'
    else
      redirect_to @post.discussion, status: :unprocessable_entity
    end
  end

  def edit
    @discussion = @post.discussion
    @reply = @post.replies.find(params[:id])
  end

  def update
    @reply = @post.replies.find(params[:id])
    if @reply.update(reply_params)
      redirect_to @post.discussion, notice: 'Your reply was updated successfully.'
    else
      redirect_to @post.discussion, status: :unprocessable_entity
    end
  end

  def destroy
    @reply = @post.replies.find(params[:id])
    @reply.destroy
    redirect_to @post.discussion
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def reply_params
    params.require(:reply).permit(:body)
  end
end

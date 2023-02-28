class Discussions::Posts::RepliesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @reply = @post.replies.new(reply_params)
    @reply.user = current_user
    if @reply.save
      redirect_to @post.discussion, notice: 'Your reply was created successfully.'
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

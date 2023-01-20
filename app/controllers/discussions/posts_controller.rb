module Discussions
  class PostsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_discussion
    before_action :set_post, only: %i[show edit update destroy]

    def show; end

    def edit; end

    def update
      respond_to do |format|
        if @post.update(post_params)
          format.html { redirect_to @post.discussion, notice: 'Your post was updated successfully.' }
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end

    def create
      @post = @discussion.posts.new(post_params)

      respond_to do |format|
        if @post.save
          format.html { redirect_to discussion_path(@discussion), notice: 'Your post was created successfully.' }
        else
          format.turbo_stream
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @post = @discussion.posts.find(params[:id])
      respond_to do |format|
        if @post.destroy
          format.turbo_stream {}
          format.html { redirect_to discussion_path(@discussion), notice: 'Your post was deleted successfully.' }
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
    end

    private

    def set_discussion
      @discussion = Discussion.find(params[:discussion_id])
    end

    def set_post
      @post = @discussion.posts.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:body)
    end
  end
end

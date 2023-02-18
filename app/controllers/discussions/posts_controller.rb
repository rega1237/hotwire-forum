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
          @pagy, @posts = pagy(@discussion.posts.all.order(created_at: :asc))
          format.html { redirect_to "/discussions/#{@discussion.id}?page=#{@pagy.last}", notice: 'Your post was created successfully.' }
        else
          format.turbo_stream
          format.html { render :new, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      # rubocop:disable all
      @post = @discussion.posts.find(params[:id])
      respond_to do |format|
        if @post.destroy
          format.turbo_stream {}
          format.html { redirect_to discussion_path(@discussion), notice: 'Your post was deleted successfully.' }
        else
          format.html { render :edit, status: :unprocessable_entity }
        end
      end
      # rubocop:enable all
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

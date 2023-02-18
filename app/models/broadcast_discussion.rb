class BroadcastDiscussion
  attr_reader :discussion

  def initialize(discussion)
    @discussion = discussion
  end

  def broadcast_discussion
    broadcast_replace
    change_category if discussion.saved_change_to_category_id?
    change_closed if discussion.saved_change_to_closed?
  end

  private

  def broadcast_replace
    @discussion.broadcast_replace(partial: 'discussions/show_top', locals: { discussion: })
  end

  def change_category
    old_category_id, new_category_id = discussion.category_id_previous_change
    old_category = Category.find(old_category_id)
    new_category = Category.find(new_category_id)

    # remove it from the old category list / insert to new list
    @discussion.broadcast_remove_to(old_category)
    @discussion.broadcast_prepend_to(new_category)

    # Update categories by replacing them. This updates the counters in the sidebar.
    old_category.reload.broadcast_replace_to('categories')
    new_category.reload.broadcast_replace_to('categories')
  end

  def change_closed
    discussion.broadcast_action_to(
      discussion,
      action: :replace,
      target: 'new_post_form',
      partial: 'discussions/posts/form',
      locals: { post: discussion.posts.new }
    )
  end
end

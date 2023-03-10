class Post < ApplicationRecord
  belongs_to :discussion, counter_cache: true, touch: true
  belongs_to :user, default: -> { Current.user }
  has_rich_text :body
  has_noticed_notifications

  after_create_commit { send_notifications }

  after_create_commit lambda {
                        broadcast_append_later_to discussion, partial: 'discussions/posts/post', locals: { post: self }
                      }
  after_update_commit lambda {
                        broadcast_replace_later_to discussion, partial: 'discussions/posts/post', locals: { post: self }
                      }
  after_destroy_commit -> { broadcast_remove_to discussion }

  validates :body, presence: true

  private

  def send_notifications
    return if Current.user == discussion.user

    NewPostNotification.with(post: self).deliver_later(discussion.user)
  end
end

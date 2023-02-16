class Discussion < ApplicationRecord
  belongs_to :user, default: -> { Current.user }
  belongs_to :category, counter_cache: true, touch: true

  delegate :name, to: :category, prefix: :category, allow_nil: true

  has_many :posts, dependent: :destroy

  accepts_nested_attributes_for :posts

  validates :title, presence: true

  broadcasts_to :category, inserts_by: :prepend

  after_create_commit -> { broadcast_append_later_to 'discussions' }
  after_update_commit -> { broadcast_replace_later_to 'discussions' }
  after_destroy_commit -> { broadcast_remove_to 'discussions' }

  def to_param
    "#{id}-#{title.downcase.to_s[0..100]}".parameterize
  end
end

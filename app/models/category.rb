class Category < ApplicationRecord
  has_many :discussions, dependent: :nullify

  scope :sorted, -> { order(name: :asc) }

  after_create_commit { broadcast_append_later_to 'categories' }
  after_update_commit { broadcast_replace_later_to 'categories' }
  after_destroy_commit { broadcast_remove_later_to 'categories' }

  validates :name, presence: true, uniqueness: true

  def to_param
    "#{id}-#{name.downcase.to_s[0..100]}".parameterize
  end
end

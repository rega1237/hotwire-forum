class Reply < ApplicationRecord
  belongs_to :user, default: -> { Current.user }
  belongs_to :post
  has_rich_text :body

  validates :body, presence: true
end

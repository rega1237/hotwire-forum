class Category < ApplicationRecord
  has_many :discussions, dependent: :nullify

  after_create_commit { broadcast_append_to 'categories' }
  after_update_commit { broadcast_replace_to 'categories' }
  after_destroy_commit { broadcast_remove_to 'categories' }


  validates :name, presence: true, uniqueness: true

end

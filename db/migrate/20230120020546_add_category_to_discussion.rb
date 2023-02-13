class AddCategoryToDiscussion < ActiveRecord::Migration[7.0]
  def change
    add_reference :discussions, :category, foreign_key: true
  end
end

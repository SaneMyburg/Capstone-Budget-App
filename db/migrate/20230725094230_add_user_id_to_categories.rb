class AddUserIdToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :user_id, :bigint
    add_index :categories, :user_id
  end
end

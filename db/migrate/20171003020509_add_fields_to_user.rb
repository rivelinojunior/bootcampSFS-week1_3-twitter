class AddFieldsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :likes_count, :integer
    add_column :users, :following_count, :integer
    add_column :users, :followed_count, :integer
    add_column :users, :tweets_count, :integer
    add_column :users, :full_name, :string
    add_column :users, :username, :string
  end
end

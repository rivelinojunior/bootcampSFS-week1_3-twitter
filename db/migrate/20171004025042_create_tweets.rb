class CreateTweets < ActiveRecord::Migration[5.0]
  def change
    create_table :tweets do |t|
      t.text :description
      t.references :user, foreign_key: true
      t.integer :likes_count

      t.timestamps
    end
  end
end

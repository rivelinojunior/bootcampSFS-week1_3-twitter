class Like < ApplicationRecord
  belongs_to :user
  belongs_to :tweet

  validates_uniqueness_of :tweet_id, scope: :user_id
end

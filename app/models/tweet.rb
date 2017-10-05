class Tweet < ApplicationRecord
  default_scope {order(created_at: :desc)}
  scope :timeline, -> user_id {get_timeline(user_id)}

  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  validates :description, presence: true, length: {maximum: 280}

  def like(user_id)
    self.likes.create user_id: user_id
  end

  def self.dislike(like_id)
    Like.destroy like_id
  end

  def self.get_timeline(user_id)
    user = User.find_by(id: user_id)
    user_ids = user.following.ids
    user_ids << user.id
    Tweet.where(user_id: user_ids).order(created_at: :desc)
  end

  def self.search(search_text)
    where(description: search_text)
  end
end

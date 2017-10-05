class Tweet < ApplicationRecord

  scope :timeline, -> user_id { get_timeline(user_id) }

  belongs_to :user

  validates :description, presence: true, length: {maximum: 280}

  def self.get_timeline(user_id)
    user = User.find_by(id: user_id)
    user_ids = user.following.ids
    user_ids << user.id
    Tweet.where(user_id: user_ids).order(created_at: :desc)
  end
end

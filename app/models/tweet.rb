class Tweet < ApplicationRecord
  default_scope {order(created_at: :desc)}
  scope :timeline, -> user_id {get_timeline(user_id)}

  belongs_to :user

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  validates :description, presence: true, length: {maximum: 280}

  acts_as_taggable_on :hashtags

  def like(user_id)
    self.likes.create user_id: user_id
  end

  def dislike(user_id)
    self.likes.where(user_id: user_id).first.destroy
  end

  def didilike?(user_id)
    user_id.in? self.liked_users.ids
  end

  def creator?(user_id)
    self.user_id.equal?(user_id)
  end

  def self.get_timeline(user_id)
    user = User.find_by(id: user_id)
    user_ids = user.following.ids
    user_ids << user.id
    Tweet.where(user_id: user_ids).order(created_at: :desc)
  end

  def self.search(search_text)
    hashtags = self.search_by_hashtag(search_text)
    description_search = where("description ~* ?", "#{search_text}").order(created_at: :desc)
    return description_search + hashtags
  end

  def self.search_by_hashtag(hashtag)
    self.tagged_with(hashtag).order(created_at: :desc)
  end

  def save_with_hashtag
    self.hashtag_list = self.description.scan(/#\w+/).map {|item| item.gsub('#', '')}
    self.save
  end
end

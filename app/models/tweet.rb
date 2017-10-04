class Tweet < ApplicationRecord
  belongs_to :user

  validates :description, presence: true, length: { maximum: 280 }
end

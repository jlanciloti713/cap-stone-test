class Message < ApplicationRecord
  belongs_to :user
  has_many :kept_messages
  validates :user, presence: true
  validates :content, presence: true, length: { maximum: 500 }

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

end

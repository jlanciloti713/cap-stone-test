class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  has_many :messages
  has_many :kept_messages
  has_many :bloops, through: :kept_messages, source: :message

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode
  
end

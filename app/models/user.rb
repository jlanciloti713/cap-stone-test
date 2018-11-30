class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  has_many :messages
  has_many :kept_messages

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode
  
end

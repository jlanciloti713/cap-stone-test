class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  has_many :messages

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  def go_to_las_vegas
    self.latitude = 36.1662859
    self.longitude = -115.149225
    p self
    save
  end

  def go_to_galesburg
    self.latitude = 40.9602781574691
    self.longitude = -90.3833142354252
    p self
    save
  end
end

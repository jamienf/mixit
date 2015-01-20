class Band < ActiveRecord::Base
  has_many :band_members, dependent: :destroy
  has_many :users, through: :band_members
  has_many :songs, dependent: :destroy

  mount_uploader :profile_photo, ProfilePhotoUploader

  validates :name,
    presence: true

  validates :bio,
    presence: true,
    length: { minimum: 1, maximum: 300 }

  validates :genre,
    presence: true
end

class Gram < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50, minimum: 3 }
  validates :message, presence: true
  has_many :comments

  mount_uploader :picture, PictureUploader
  acts_as_voteable
  belongs_to :user
end

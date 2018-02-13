class Gram < ApplicationRecord
  acts_as_voteable
  validates :title, presence: true, length: { maximum: 50, minimum: 3 }
  validates :message, presence: true
  has_many :comments

  mount_uploader :picture, PictureUploader
  belongs_to :user
end

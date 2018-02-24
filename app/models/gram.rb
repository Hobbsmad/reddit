class Gram < ApplicationRecord
  acts_as_voteable
  validates :title, presence: true, length: { maximum: 50, minimum: 3 }
  validates :message, presence: true
  has_many :comments

  mount_uploader :picture, PictureUploader
  belongs_to :user

  def self.search(search)
  # Title is for the above case, the OP incorrectly had 'name'
    where("title LIKE ?", "%#{search}%")
  end
end

class User < ApplicationRecord
  acts_as_voter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :grams
  has_many :comments

  def self.upvote(id)
    self.where(:id => id).update_all("upvotes = upvotes + 1")
  end

  def self.downvote(id)
    self.where(:id => id).update_all("downvotes = downvotes + 1")
  end
end

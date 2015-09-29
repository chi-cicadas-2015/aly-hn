class User < ActiveRecord::Base
  has_many :posts
  has_many :comments, foreign_key: "commenter_id"

  has_secure_password

  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
end

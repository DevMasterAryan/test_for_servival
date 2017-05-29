class User < ApplicationRecord
	has_secure_password
  has_many :user_friends
  has_many :friends
  validates :user_name, :first_name, :last_name, :email, :password, presence: :true
  validates :email, :user_name, uniqueness: :true


end

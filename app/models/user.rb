class User < ApplicationRecord
  has_secure_password
  
  #has_many :friendships
  #has_many :friends, :through => :friendships
  #has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  #has_many :inverse_friends, :through => :inverse_friendships, :source => :user


  # All the users thats are requesting to be friends with current user
  has_many :friend_requests, -> { where(accepted: false) }, class_name: 'Friendship',
                                                            foreign_key: :friend_id
  has_many :requesters, through: :friend_requests, source: :user

  # All the users, current user has sent requests to be friends with
  has_many :requested_friends, -> { where(accepted: false) }, class_name: 'Friendship',
                                                              foreign_key: :user_id
  has_many :requestees, through: :requested_friends, source: :friend

  # Established friendships through acceptence
  has_many :friendships, -> { where(accepted: true) }
  has_many :friends, through: :friendships
  has_many :inverse_friendships, -> { where(accepted: true) }, class_name: 'Friendship',
                                                               foreign_key: :friend_id
  has_many :inverse_friends, through: :inverse_friendships, source: :user
  
  validates :user_name, :first_name, :last_name, :email, :password, presence: :true
  validates :email, :user_name, uniqueness: :true


end

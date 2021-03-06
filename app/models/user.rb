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
  
  validates :user_name, :first_name, :last_name, :email, :password, presence: :true ,:on => :create
  validates :email, :user_name, uniqueness: :true
  

  def send_friend_request(other_user)
    requested_friends.create(friend_id: other_user.id)
  end

  def cancel_friend_request(other_user)
    requested_friends.find_by(friend_id: other_user.id).destroy
  end

  def friends?(other_user)
    friends.include?(other_user)
  end

  def inverse_friends?(other_user)
    inverse_friends.include?(other_user)
  end

  def already_requested?(other_user)
    requestees.include?(other_user)
  end

  def request_from?(other_user)
    requesters.include?(other_user)
  end

  def feed
    friends_ids = "SELECT user_id FROM friendships
                   WHERE friend_id = #{id}"
    Post.where("user_id IN (#{friends_ids}) OR user_id = :user_id", user_id: id)
  end

  def inverse_feed
    inverse_friends_ids = "SELECT friend_id FROM friendships
                           WHERE user_id = :user_id"
    Post.where("user_id IN (#{inverse_friends_ids})", user_id: id)
  end

  def full_name
    first_name + ' ' + last_name
  end

  def format_first_name
    self.first_name = first_name.downcase.capitalize
  end

  def format_last_name
    self.last_name = last_name.downcase.capitalize
  end
   

end

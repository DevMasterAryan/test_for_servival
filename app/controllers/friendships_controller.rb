class FriendshipsController < ApplicationController
=begin  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      flash[:notice] = "Added friend."
      redirect_to users_path(current_user)
    else
      flash[:error] = "Unable to add friend."
      redirect_to root_url
    end
  end
  
  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Removed friendship."
    redirect_to current_user
  end
end
=end

def index
    load_user
    all_friends
    @friendships += all_inverse_friends
  end

  # Request friendship
  def create
    #debugger
    find_user_friending
    current_user.send_friend_request(@user_friending)
    redirect_to @user_friending
  end

  # Accept Friendship request
  def update
    find_request
    accept_request
    redirect_to root_url
  end

  # Cancel or Ignore Friendship or request
  def destroy
    find_request
    @request.destroy
    redirect_to root_url
  end

  private

  def load_user
    @user = User.find(params[:user_id])
  end

  def all_friends
    @friendships ||= @user.friends.all
  end

  def all_inverse_friends
    @inverse_friendships = @user.inverse_friends.all
  end

  def find_request
    @request = Friendship.find(params[:id])
  end

  def accept_request
    @request.update(accepted: true)
  end

  def find_user_friending
    @user_friending = User.find(params[:friend_id])
  end

  def verify_requestee
    find_request
    redirect_to root_url unless requestee?(@request)
  end

  def requestee?(request)
    request.friend_id == current_user.id
  end
end
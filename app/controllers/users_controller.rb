class UsersController < ApplicationController
  


  def index
    @users = User.all	
  end

  def signup
  	@user =  User.new
  end

  def new
  	@user = User.new
  end
  def create
    @user  = User.new(user_params)
  	if @user.save
  	  render 'sessions/new'
  	else
  	  render 'signup'
  	end
  	
  end

  
  def show
  	@user = current_user
  	 
  end

  def home
  end

  

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :user_name, :image, :email, :password )
  end
end

class UsersController < ApplicationController
  def signup
  	@user =  User.new
  end

  def create
    @user  = User.new(user_params)
  	if @user.save
  	  redirect_to 'signin'
  	else
  	  render 'signup'
  	end
  	
  end

  
  def show
  	 
  end

  def home
  end

  

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :user_name, :image, :email, :password )
  end
end

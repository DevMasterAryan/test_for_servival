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

  def signin
    
  end

  def login
   	
  end
  def authorise_user
  
  	@user = User.find_by_user_name(params[:user_name])

  	if User.find_by_user_name(params[:user_name]) && User.find_by_password(params[:password])
      redirect_to home_path
    else
      render 'signup' 
   	end
  	
  end
  def home
  	
  	
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :user_name, :image, :email, :password )
  end
end

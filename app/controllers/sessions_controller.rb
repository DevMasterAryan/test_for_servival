class SessionsController < ApplicationController
	#before_action :logged_in?

  def new
  end
  def create
  	user  = User.find_by_user_name(params[:session][:user_name].downcase) || User.find_by_email(params[:session][:user_name].downcase)
    #mail = User.find_by_email(params[:session][:user_name].downcase)
  	if user && user.authenticate(params[:session][:password])
  		
  		log_in user
  		flash[:success] = "login success"
  		redirect_to user_path(current_user)
  	   
  	else
  		flash[:danger]  = "invalid user or password..retry again...!!!"
  		render 'new'
  	end
  end

  def destroy
    log_out
    redirect_to login_path   	
  end
end

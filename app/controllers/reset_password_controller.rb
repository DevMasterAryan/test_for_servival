class ResetPasswordController < ApplicationController
  def new
  end

  def create
  	@user = User.find_by(email: params[:email],security_answer: params[:security_answer])
    if @user
      redirect_to edit_reset_password_path(@user)
    else
    	flash[:danger] = "Invalid email or security_answer"
       render 'new'
    end
  end

  def edit
    @user = User.find_by(email: params[:email],security_answer: params[:security_answer])  	
  end

  def update
  	@user = User.find_by(id: params[:id])
  	@pass= @user.update(password: params[:password])
  	if @pass
  		flash[:success] = "Password Updated Sucessfully"
  		redirect_to login_path
  	else
  		flash[:danger] = "oops something went wrong try again..."
  		render 'edit'
  	end
  end
end

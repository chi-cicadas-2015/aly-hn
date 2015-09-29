class SessionsController < ApplicationController
  def create
    if @user = User.find_by(email: params[:email]).try(:authenticate, params[:password])
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end

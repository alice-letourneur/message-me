class SessionsController < ApplicationController
  before_action :logged_in_redirect, only: [:new, :create]

  def new

  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = ["Success", "You've successfully logged in"]
      redirect_to root_path
    else
      flash.now[:error] = ["There was a problem", "Your username and/or password are incorrect"]
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = ["We hope to see you soon!", "You've successfully logged out"]
    redirect_to login_path
  end

  private

  def logged_in_redirect
    if logged_in?
      flash[:warning] = ["You are already logged in"]
      redirect_to root_path
    end
  end
end

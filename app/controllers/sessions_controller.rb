class SessionsController < ApplicationController

  def create
    user = user_credentials
    session[:user_id] = user.id
    redirect_to exercises_path
  end


  private
    attr_reader :user_credentials

  def user_credentials
    env["omniauth.auth"]
  end
end

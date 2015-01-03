class UsersController < ApplicationController
  before_filter :authenticate_user!

  def profile
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if params[:user][:password].present?
      @user.update_attributes(:username => params[:user][:username], :name => params[:user][:name],
                              :password => params[:user][:password], :password_confirmation => params[:user][:password_confirmation],
                              :u_type => params[:user][:u_type])
    else
      @user.update_attributes(:username => params[:user][:username], :name => params[:user][:name],
                              :u_type => params[:user][:u_type])
    end

    redirect_to "/users"
  end

  def show
    @user = User.find(params[:id])
  end
end

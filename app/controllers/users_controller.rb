class UsersController < ApplicationController
  def index 
    @users = User.all
  end

  def show
    id = params[:id]
    @user = User.find(params[:id])
    @new_message = Message.new
  end
end

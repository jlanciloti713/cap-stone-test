class UsersController < ApplicationController
  before_action :authenticate_user!
  def index 
    @users = User.all
  end

  def show
    id = params[:id]
    @user = User.find(params[:id])
    @new_message = Message.new

  end

  def updateposition
    @user = User.find(current_user.id)
    render({json: @user, status: 200})
  end
end

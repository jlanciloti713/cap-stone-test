class UsersController < ApplicationController
  before_action :authenticate_user!
  def index 
    @users = User.all
  end

  def show
    id = params[:id]
    Message.unscoped.order(id: :desc)
    @user = User.find(params[:id])
    @new_message = Message.new

  end

  def update_position
    @user = User.find(current_user.id)
    render({json: @user, status: 200})
    @user.update(latitude: params[:userLatitude], longitude: params[:userLongitude])
  end
end

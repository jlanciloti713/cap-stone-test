class UsersController < ApplicationController
  before_action :authenticate_user!
  def index 
    @users = User.all
  end

  def show
    # message_id = params[:message_id]
    # @kept_message = KeptMessage.find_by(params[:message_id])
    id = params[:id]
    if params[:id]
      @user = User.find(params[:id])
      Message.unscoped.order(id: :desc)
      @new_message = Message.new
    else
      @user = current_user
      Message.unscoped.order(id: :desc)
      @new_message = Message.new
    end
  end

  def update_position
    @user = User.find(current_user.id)
    @user.update(latitude: params[:userLatitude], longitude: params[:userLongitude])
    @messages = Message.near([@user.latitude, @user.longitude], 0.01)
    @message_amount = @messages.length
    render({json: {user: @user, nearby_messages: @messages}, status: 200})
  end
end

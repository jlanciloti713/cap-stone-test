class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!, only: [:index]
  def index 
    @users = User.all
  end

  def update_show
    id = params[:id]
    if params[:id]
      @user = User.find(params[:id])
      Message.unscoped.order(id: :desc)
      @new_message = Message.new
    else
      @user = current_user
      Message.unscoped.order(id: :desc)
      @new_message = Message.new

      respond_to do |format|
        format.json do
          render json: @user.messages, include: :kept_messages
        end
        format.html {render 'show'}
      end
    end 
  end
  
  def show
    id = params[:id]
    if params[:id]
      @user = User.find(params[:id])
      Message.unscoped.order(id: :desc)
      @new_message = Message.new
    else
      @user = current_user
      Message.unscoped.order(id: :desc)
      @new_message = Message.new

      respond_to do |format|
        format.json do
          render json: @user.messages, include: :kept_messages
        end
        format.html {render 'show'}
      end
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

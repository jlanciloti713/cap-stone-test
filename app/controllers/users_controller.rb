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
      @user_messages = Message.where(archived: false, user_id: @user.id).order(id: :desc)
      @new_message = Message.new
    else
      @user = current_user
      @user_messages = Message.where(archived: false, user_id: @user.id).order(id: :desc)
      Message.unscoped.order(id: :desc)
      @new_message = Message.new

      respond_to do |format|
        format.json do
          render json: @user.messages.order(created_at: :desc), include: :kept_messages
        end
        format.html {render 'show'}
      end
    end 
  end
  
  def show
    id = params[:id]
    if params[:id]
      @user = User.find(params[:id])
      @user_messages = Message.where(archived: false, user_id: @user.id).order(id: :desc)
      @new_message = Message.new
    else
      @user = current_user
      @user_messages = Message.where(archived: false, user_id: @user.id).order(id: :desc)
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
    @messages = Message.where(archived: false).near([@user.latitude, @user.longitude], 0.01)
    @unkept_nearby_messages = @messages - @user.bloops.where(archived: false).near([@user.latitude, @user.longitude], 0.01) 
    @message_amount = @unkept_nearby_messages.length

    render({json: {user: @user, nearby_messages: @unkept_nearby_messages}, status: 200})
  end
  
end

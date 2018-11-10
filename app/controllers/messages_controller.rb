class MessagesController < ApplicationController
  def index
    redirect_back(fallback_location: "/users")
  end

  def create
    @new_message = Message.create( content: params[:content], user_id: params[:user_id], latitude: params[:latitude], longitude: params[:longitude])
    redirect_to("/users/#{@new_message.user.id}")
  end
end

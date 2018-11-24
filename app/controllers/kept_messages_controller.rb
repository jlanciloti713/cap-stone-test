class KeptMessagesController < ApplicationController

  def create
    @kept_message = KeptMessage.create( user_id: params[:user_id], message_id: params[:message_id], is_kept: true)

    redirect_to "/messages/#{current_user.id}"
  end
  def index
    
    @kept_messages = KeptMessage.all
  end
end

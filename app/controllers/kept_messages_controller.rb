class KeptMessagesController < ApplicationController

  def create
    @kept_message = KeptMessage.create(user_id: params[:user_id], message_id: params[:message_id], is_kept: true)
    redirect_to "/messages/#{current_user.id}"
    flash[:success] = "You kept it!"
  end

  def index
    @kept_messages = KeptMessage.all
  end
    
  def destroy
      user_id = KeptMessage.find(params[:id]).user_id
        KeptMessage.find(params[:id]).destroy
        redirect_to "/kept_messages"
  end

end




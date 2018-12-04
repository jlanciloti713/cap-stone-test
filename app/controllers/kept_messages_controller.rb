class KeptMessagesController < ApplicationController

  def create
    @kept_message = KeptMessage.create(user_id: params[:user_id], message_id: params[:message_id], is_kept: true)
    @amount_of_times_kept = 
    respond_to do |format|
      format.html {redirect_to "/messages/#{current_user.id}"}
      format.json {render json: {keptMessages: @kept_messages}, status: 200}
    end
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




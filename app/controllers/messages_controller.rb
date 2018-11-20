class MessagesController < ApplicationController
  def index
    redirect_back(fallback_location: "/users")
  end

  def create
    @new_message = Message.new( content: params[:content], user_id: params[:user_id], latitude: params[:latitude], longitude: params[:longitude])

    respond_to do |format|
      if @new_message.save
        # format.html {redirect_to("/users/#{@new_message.user.id}")}
        format.json {render json: @new_message}
      end
    end
  end


end

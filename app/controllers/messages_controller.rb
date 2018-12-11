class MessagesController < ApplicationController
  def index
    redirect_back(fallback_location: "/users")
  end

  def create
    @new_message = Message.new( content: params[:content], user_id: params[:user_id], latitude: params[:latitude], longitude: params[:longitude])

    respond_to do |format|
      if @new_message.save
        format.json {render json: @new_message, include: :kept_messages}
        format.html {redirect_to("/users/#{@new_message.user.id}")}
      else
        format.html do
          @user = User.find(params[:id])
          render '/users/show'
        end
        format.json {render json: {errors: @new_message.errors.full_messages}, status: 400}
      end
    end
  end

  def update

    @message = Message.find(params[:id])
    @message.update( archived: true )
    redirect_to "/users/#{current_user.id}"
  end
      
  def destroy
      user_id = Message.find(params[:id]).user_id
        Message.find(params[:id]).delete
        redirect_to "/users/#{user_id}"
  end

  def found_messages
    id = params[:id]
    @user = User.find(params[:id])
    @close_messages = Message.where(archived: false )
  end

end



class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.create(msg_params)
    if @message.save
      ActionCable.server.broadcast "room_channel_#{@message.room_id}",
                                    content: @message.content,
                                    username: @message.user.username,
                                    clearForm: true
    end                                                  
  end

  def destroy
    @message = Message.find params[:id]
    @message.destroy
  end

  private

  def msg_params
    params.require(:message).permit(:content, :user_id, :room_id)
  end
end

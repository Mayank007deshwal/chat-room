class RoomsController < ApplicationController
  before_action :authenticate_user!
  def create
    @message = Message.new
    @room = Room.new(room_params.merge(user_id: current_user.id))

    if @room.save
      redirect_to room_path(@room)
    end
  end

  def show
    @room = Room.find(params[:id])
    @message = Message.new
  end

  def index
    @rooms = Room.all
    @room = Room.new
    render 'rooms/index'
  end

  def destroy
    @room = Room.find params[:id]
    @room.destroy
    render 'rooms/index'
  end

  private

  def room_params
    params.require(:room).permit(:name, :user_id)
  end
end

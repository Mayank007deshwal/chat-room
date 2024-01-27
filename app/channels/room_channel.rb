class RoomChannel < ApplicationCable::Channel
  # @@connected_users = Set.new

  def subscribed
    current_user.update(is_online: true) if current_user
    stream_from "room_channel_#{params[:room_id]}"
  
    # @@connected_users.add(params[:current_user])
    # broadcast_status
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    # @@connected_users.delete(params[:current_user])
    # broadcast_user_count
    current_user.update(is_online: false) if current_user
    disappear
  end

  def disconnect
    current_user.update(is_online: false) if current_user
    disappear
    super
  end

  # private

  def appear
    current_user.update(is_online: true)
    ActionCable.server.broadcast "room_channel_#{params[:room_id]}", user_id:
     "#{current_user.id}", status: "online"
     
  end

  def disappear
    ActionCable.server.broadcast "room_channel_#{params[:room_id]}", user_id:
     "#{current_user.id}", status: "offline"
  end
end

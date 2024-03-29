class PresenceChannel < ApplicationCable::Channel
  def subscribed
    stream_from "presence_channel_#{current_user.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end

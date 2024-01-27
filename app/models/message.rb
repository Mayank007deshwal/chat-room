class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  after_create :send_notification

  def send_notification
    all_users = room.users.where.not(id: user.id).distinct

    all_users.each do |offline_user|
      if !offline_user.is_online?
        call_broadcast(offline_user)
      end
    end
  end

  def call_broadcast(offline_user)
    ActionCable.server.broadcast "presence_channel_#{offline_user.id}", msg: content, to_user: offline_user.username
  end
end

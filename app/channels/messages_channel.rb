class MessagesChannel < ApplicationCable::Channel
  def subscribed
    channel = Channel.find(params[:channel_id])
    stream_for channel
  end

  def unsubscribed
  end
end

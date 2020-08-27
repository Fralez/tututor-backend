class MessagesChannel < ApplicationCable::Channel
  def subscribed
    channel = Channel.find(params[:channel])
    stream_for channel
  end

  def unsubscribed
  end
end

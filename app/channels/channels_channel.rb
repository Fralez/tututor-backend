class ChannelsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "channels_channel"
  end

  def unsubscribed
  end
end
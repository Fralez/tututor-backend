class ChannelsController < ApplicationController
  def index
    channels = Channel.all
    render json: channels
  end

  def create
    channel = Channel.new(channel_params)
    if channel.save
      ActionCable.server.broadcast 'channels_channel', channel.as_json
      head :ok
    end
  end

  private

  def channel_params
    params.require(:channel).permit(:name)
  end
end

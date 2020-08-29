class ChannelsController < ApplicationController
  def index
    channels = Channel.all
    render json: channels.as_json, status: :ok
  end

  def show
    user_one_id = params[:user_one_id]
    user_two_id = params[:user_two_id]

    channel = Channel.where(user_one_id: [user_one_id, user_two_id],
                            user_two_id: [user_one_id, user_two_id])
    render json: channel.as_json, status: :ok
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

# frozen_string_literal: true

class ChannelsController < ApplicationController
  include CurrentUserConcern

  def index
    channels = Channel.where(user_one_id: @current_user.id)
                      .or(Channel.where(user_two_id: @current_user.id))
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
    channel = Channel.find_or_initialize_by(channel_params)
    if channel.save
      ActionCable.server.broadcast 'channels_channel', channel.as_json
      render json: channel.as_json, status: :created
    else
      render json: channel.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def channel_params
    params.require(:channel).permit(:name, :user_one_id, :user_two_id)
  end
end

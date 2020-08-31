# frozen_string_literal: true

class MessagesController < ApplicationController
  include CurrentUserConcern

  def index
    messages = Message.all.where(channel_id: params[:channel_id])
    render json: messages.as_json, status: :ok
  end

  def create
    message = Message.new(message_params)
    message.user = @current_user
    channel = Channel.find(message.channel_id)
    if message.save
      MessagesChannel.broadcast_to channel, message.as_json
      head :ok
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :channel_id)
  end
end

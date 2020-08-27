# frozen_string_literal: true

class MessagesController < ApplicationController
  include CurrentUserConcern

  def create
    message = Message.new(message_params)
    message.user = @current_user
    if message.save
      render json: { message: message.as_json },
             status: :created
    else
      render json: { errors: message.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :channel_id)
  end
end

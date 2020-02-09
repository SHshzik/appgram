module Api
  module V1
    class MessagesController < ApplicationController
      before_action :current_user
      before_action :set_room

      def index
        # TODO: add where
        messages = @room.messages
        render json: messages
      end

      def show
        # TODO: add 404 error handler
        # TODO: add where
        message = Message.find(params[:id])
        render json: message
      end

      def create
        # TODO: add check params
        message = Message.new(message_params)
        if message.save
          render json: message
        else
          render json: { status: false, errors: message.errors }
        end
      end

      private

      def message_params
        params
          .require(:message)
          .permit(:msg)
          .merge(
            sender_id: @current_user.id,
            room: Room.find(params[:message][:room])
          )
      end

      def current_user
        @current_user ||= User.find(1)
      end

      def set_room
        @room = Room.find(params[:room_id])
      end
    end
  end
end

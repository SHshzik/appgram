module Api
  module V1
    class MessagesController < ApplicationController
      before_action :current_user
      before_action :set_room

      def index
        messages = @room.messages.order(updated_at: :desc)
        if params.include?'from'
          messages = messages.where('updated_at < ?', DateTime.parse(params[:from]))
        end
        @messages = messages.page(1).per(10)
        @last_message = @messages.last
        render :index
      end

      # def show
      #   message = Message.find(params[:id])
      #   render json: message
      # end

      def create
        message = Message.new(message_params)
        message.room = @room
        message.sender_id = @current_user.id
        if message.save
          render json: message
        else
          render json: { status: false, errors: message.errors }
        end
      end

      def update
        message = Message.find(params[:id])
        if message.update_attributes(message_params)
          render json: message
        else
          render json: { status: false, errors: message.errors }
        end
      end

      def destroy
        message = @room.messages.where(sender_id: @current_user.id).find(params[:id])
        message.destroy
        render json: {}, status: :ok
      end

      private

      def message_params
        params.require(:message).permit(:msg)
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

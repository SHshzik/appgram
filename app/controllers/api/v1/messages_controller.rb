module Api
  module V1
    class MessagesController < BaseController

      rescue_from 'ActiveRecord::RecordNotFound' do
        render json: {
          status: false, message: "Комната с id №#{params[:room_id]} не найдена"
        }, status: 404
      end

      def index
        messages = current_room.messages.order(updated_at: :desc)
        options, messages = DataService.new(messages, current_user).call(data_params)
        render json: MessageSerializer.new(messages, options)
      end

      def create
        message = current_room.messages.new(message_params)
        message.sender_id = current_user.id
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
        message = current_room.messages.where(sender_id: current_user.id).find(params[:id])
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

      def current_room
        @room = Room.find(params[:room_id])
      end
    end
  end
end

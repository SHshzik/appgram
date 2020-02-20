module Api
  module V1
    class MessagesController < BaseController
      before_action :build_form, only: [:update, :create]

      rescue_from 'ActiveRecord::RecordNotFound' do
        render json: { status: false, message: "Комната с id №#{params[:room_id]} не найдена" }, status: :not_found
      end

      def index
        messages = current_room.messages.order(updated_at: :desc)
        get_messages = GetMessages.new(messages, current_user, current_room)
        options, messages = get_messages.call(data_params)
        render json: MessageSerializer.new(messages, options), status: :ok
      end

      def create
        if @form.valid?
          render json: @form.create, status: :created
        else
          render json: @form.errors, status: :bad_request
        end
      end

      def update
        if @form.valid?
          render json: @form.update, status: :accepted
        else
          render json: @form.errors, status: :bad_request
        end
      end

      def destroy
        message = current_room.messages.where(sender_id: current_user.id).find(params[:id])
        message.destroy
        render status: :no_content
      end

      private

      def message_params
        params.require(:message).permit(:msg)
      end

      def current_room
        @room = current_user.rooms.find(params[:room_id])
      end

      def build_form
        @form = MessageForm.new(
          message: Message.where(id: params[:id]).first,
          msg: message_params[:msg],
          user: current_user,
          room: current_room
        )
      end
    end
  end
end

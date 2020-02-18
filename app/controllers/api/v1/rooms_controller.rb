module Api
  module V1
    class RoomsController < BaseController
      rescue_from 'ActiveRecord::RecordNotFound' do
        render json: {
          status: false, message: "Комната с id №#{params[:id]} не найдена"
        }, status: :not_found
      end

      def index
        rooms = current_user.rooms.order(updated_at: :desc)
        options, rooms = GetRooms.new(rooms, current_user).call(data_params)
        render json: RoomSerializer.new(rooms, options), status: :ok
      end

      def show
        room = current_user.rooms.includes(:users).where(users: { id: current_user }).find(params[:id])
        render json: room, status: :ok
      end

      def destroy
        room = current_user.rooms.find(params[:id])
        room.destroy
        render status: :no_content
      end

      def create
        room = Room.new(room_params)
        if room.save
          render json: room, status: :created
        else
          render json: { status: false, errors: room.errors }, status: :bad_request
        end
      end

      private

      def room_params
        users = params.require(:room).permit(users: [])
        users[:users] = users[:users].map do |user_id|
          User.find user_id
        end
        users[:users].append current_user
        users
      end
    end
  end
end

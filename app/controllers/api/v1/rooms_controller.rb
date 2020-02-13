module Api
  module V1
    class RoomsController < ApplicationController
      before_action :current_user

      def index
        rooms = @current_user.rooms.order(updated_at: :desc)
        if params.include?'from'
          rooms = rooms.where('updated_at <= ?', DateTime.parse(params[:from]))
        end
        @rooms = rooms.page(params[:page] || 1).per(10)
        render :index
      end

      def show
        room = Room.includes(:users).where(users: { id: @current_user }).find(params[:id])
        render json: room
      end

      def create
        room = Room.new(room_params)
        if room.save
          render json: room
        else
          render json: { status: false, errors: room.errors }
        end
      end

      private

      def room_params
        users = params.require(:room).permit(users: [])
        users[:users] = users[:users].map do |user_id|
          User.find user_id
        end
        users[:users].append @current_user
        users
      end

      def current_user
        @current_user ||= User.find(1)
      end
    end
  end
end

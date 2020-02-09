module Api
  module V1
    class RoomsController < ApplicationController
      # TODO: add right json response
      # TODO: rework json response with new
      before_action :current_user

      def index
        rooms = Room.includes('users').where(users: { id: @current_user })
        render json: rooms
      end

      def show
        room = Room.includes(:users).where(users: { id: @current_user }).find(params[:id])
        render json: room
      end

      def create
        room = Room.new(room_params)
        if room.save
          render json: room.to_json(include: [:users])
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

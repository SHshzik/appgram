module Api
  module V1
    class RoomsController < ApplicationController
      before_action :current_user

      rescue_from 'ActiveRecord::RecordNotFound' do
        render json: {
          status: false, message: "Комната с id №#{params[:id]} не найдена"
        }, status: 404
      end

      rescue_from 'ActionController::ParameterMissing' do |exception|
        render json: { status: false, message: exception.to_s }, status: 500
      end

      def index
        rooms = @current_user.rooms.order(updated_at: :desc)
        if params.include? 'from'
          rooms = rooms.where('updated_at < ?', DateTime.parse(params[:from]))
        end
        # TODO: mv hard code
        @has_next = rooms.count > 10
        @rooms = rooms.limit(10)
        @last_room = @rooms.last
        render :index
      end

      def show
        room = @current_user.rooms.includes(:users).where(users: { id: @current_user }).find(params[:id])
        render json: room
      end

      def destroy
        room = @current_user.rooms.find(params[:id])
        room.destroy
        render json: {}, status: :ok
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

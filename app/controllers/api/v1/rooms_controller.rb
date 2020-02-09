module Api
  module V1
    class RoomsController < ApplicationController
      def index
        @rooms = Room.all
        render json: @rooms
      end

      def show
        @room = Room.find(params[:id])
        render json: @room
      end
    end
  end
end

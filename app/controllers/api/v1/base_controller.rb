module Api
  module V1
    class BaseController < ApplicationController
      # rescue_from 'ActiveRecord::RecordNotFound' do
      #   render json: {
      #       status: false, message: "Комната с id №#{params[:room_id]} не найдена"
      #   }, status: 404
      # end

      rescue_from 'ActionController::ParameterMissing' do |exception|
        render json: { status: false, message: exception.to_s }, status: :bad_request
      end

      private

      def data_params
        params.permit(:from, :to)
      end

      def current_user
        @current_user ||= User.find(1)
      end
    end
  end
end

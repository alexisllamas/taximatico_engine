module Api
  module Users
    class DriverRequestsController < ::Api::Users::BaseController
      def create
        ::Users::Requests::Create.(driver_request_arguments)
      end

      def progress
        @driver_locations = driver_request.driver_locations
      end

      helper_method :driver_request

      private

      def driver_request
        @driver_request ||= current_user.driver_requests.find(params[:id])
      end

      def driver_request_arguments
        { user: current_user,
          latitude: driver_request_params[:latitude],
          longitude: driver_request_params[:longitude],
          success: method(:create_success),
          error: method(:create_error) }
      end

      def create_success(driver_request)
        @driver_request = driver_request
        render :show, status: :created
      end

      def create_error(error)
        render json: { status: "error", error: error },
          status: :unprocessable_entity
      end

      def driver_request_params
        params.fetch(:driver_request, {}).permit(:latitude, :longitude)
      end
    end
  end
end

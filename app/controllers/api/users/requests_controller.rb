module Api
  module Users
    class RequestsController < ::Api::Users::BaseController
      def create
        ::Users::Requests::Create.(request_arguments)
      end

      private

      def request_arguments
        { user: user,
          latitude: request_params[:latitude],
          longitude: request_params[:longitude],
          success: method(:create_success),
          error: method(:create_error) }
      end

      def create_success(user_request)
        @request = user_request
        render :show, status: :created
      end

      def create_error(error)
        render json: { status: "error", error: error },
          status: :unprocessable_entity
      end

      def request_params
        params.fetch(:request, {}).permit(:latitude, :longitude)
      end
    end
  end
end

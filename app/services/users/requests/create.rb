module Users
  module Requests
    class Create < BaseService
      attr_reader :user, :latitude, :longitude, :success, :error

      def initialize(user:, latitude:, longitude:, success:, error: -> {})
        @user, @latitude, @longitude = user, latitude, longitude
        @success, @error = success, error
      end

      def perform
        return error.call("multiple_requests_not_allowed") if Request.has_active_requests? user

        if drivers_around?
          success.call(request)
        else
          error.call("no_drivers_around")
        end
      end

      private

      def drivers_around?
        Driver.geosearch(latitude, longitude).any?
      end

      def request
        @request ||= Request.create_request(user, latitude, longitude)
      end
    end
  end
end

module Users
  module Requests
    class Create < BaseService
      attr_reader :user, :latitude, :longitude, :success, :error

      def initialize(user:, latitude:, longitude:, success:, error: -> {})
        @user, @latitude, @longitude = user, latitude, longitude
        @success, @error = success, error
      end

      def perform
        return error.call("multiple_driver_requests_not_allowed") if has_active_driver_requests?

        if drivers_around?
          success.call(driver_request)
        else
          error.call("no_drivers_around")
        end
      end

      private

      def drivers_around?
        Geosearch.for(Driver, latitude, longitude, "1km").any?
      end

      def has_active_driver_requests?
        Driver::Request.has_active_driver_requests? user
      end

      def driver_request
        @driver_request ||= Driver::Request.create_driver_request(user, latitude, longitude)
      end
    end
  end
end

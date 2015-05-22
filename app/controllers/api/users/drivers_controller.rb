module Api
  module Users
    class DriversController < ::Api::Users::BaseController
      def index
        results = Geosearch.for(Driver, latitude, longitude, "1km")
        @drivers = results.free
      end

      private

      def latitude
        params[:latitude].to_f
      end

      def longitude
        params[:longitude].to_f
      end
    end
  end
end

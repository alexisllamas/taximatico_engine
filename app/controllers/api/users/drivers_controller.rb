module Api
  module Users
    class DriversController < ::Api::Users::BaseController
      def index
        @drivers = Geosearch.for(Driver, latitude, longitude, "1km")
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

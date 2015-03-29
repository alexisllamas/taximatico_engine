require 'uri'
require 'net/http'

namespace :taximatico do
  task poke_website: :environment do
    Net::HTTP.get_response(URI.parse("http://api.taximatico.com"))
  end
end

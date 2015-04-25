require "elasticsearch/model"

class Driver < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  mapping do
    indexes :name,        type: "string"
    indexes :taxi_number, type: "integer"
    indexes :location,    type: "geo_point"
  end

  def self.create_driver(name, taxi_number, latitude, longitude)
    create!(name: name,
            taxi_number: taxi_number,
            latitude: latitude,
            longitude: longitude)
  end

  def self.geosearch(latitude, longitude)
    search({ query: {
      filtered: {
        query: { match_all: {} },
        filter: {
          geo_distance: {
            distance: "1km",
            location: { lat: latitude, lon: longitude }
          }
        }
      }
    }}).records.to_a
  end

  def location
    { lat: latitude, lon: longitude }
  end

  def as_indexed_json(options={})
    as_json(only: [ :name, :taxi_number ],
            methods: [ :location ])
  end
end

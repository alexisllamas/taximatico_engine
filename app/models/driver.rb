require "elasticsearch/model"

class Driver < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  has_many :locations, class_name: "Driver::Location"
  has_many :requests

  enum status: [ :free, :busy ]

  mapping do
    indexes :id,          type: "integer"
    indexes :name,        type: "string"
    indexes :taxi_number, type: "integer"
    indexes :location,    type: "geo_point"
  end

  def self.create_driver(name, taxi_number)
    driver = create!(name: name, taxi_number: taxi_number)
    driver.__elasticsearch__.index_document
    driver
  end

  def update_location(latitude, longitude)
    Driver::Location.create_location(self, latitude, longitude)
    __elasticsearch__.update_document_attributes(as_indexed_json)
  end

  def location
    { lat: current_location.try(:latitude) || 0,
      lon:  current_location.try(:longitude) || 0 }
  end

  def current_location
    locations.last
  end

  def as_indexed_json(options={})
    as_json(only: [ :id, :name, :taxi_number ],
            methods: [ :location ])
  end
end

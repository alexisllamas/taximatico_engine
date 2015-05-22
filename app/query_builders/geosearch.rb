class Geosearch
  def self.for(*args)
    new(*args).results
  end

  attr_reader :klass, :latitude, :longitude, :distance

  def initialize(klass, latitude, longitude, distance)
    @klass     = klass
    @latitude  = latitude
    @longitude = longitude
    @distance  = distance
  end

  def results
    klass.search(search_hash).records
  end

  def search_hash
    @search_hash = {
      sort:  { id: { order: :asc } },
      query: { filtered: {
        query:  { match_all: {} },
        filter: { geo_distance: {
          distance: distance,
          location: { lat: latitude, lon: longitude }
        } }
      } }
    }
  end
end

require_relative "../../app/query_builders/geosearch.rb"

describe Geosearch do
  let(:klass)     { double :driver, search: double(:search, records: []) }
  let(:latitude)  { 100 }
  let(:longitude) { 100 }
  let(:distance) { "2km" }

  subject { Geosearch.new(klass, latitude, longitude, distance) }

  describe "#results" do
    it "calls the search method from the klass" do
      expect(klass).to receive(:search).
        with(subject.search_hash).and_return(double(:search, records: []))
      subject.results
    end
  end

  describe "#search_hash" do
    it "returns the search hash" do
      expect(subject.search_hash).to eq({
        sort:  { id: { order: :asc } },
        query: { filtered: {
          query:  { match_all: {} },
          filter: { geo_distance: {
            distance: distance,
            location: { lat: latitude, lon: longitude }
          } }
        } }
      })
    end
  end
end

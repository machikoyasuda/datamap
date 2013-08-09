class Station
  include MongoMapper::Document
  belongs_to :line
  many :datapoints

  key :name, String
  key :number, String

  key :location, Hash

  key :status, Boolean
  key :established_at, Date

  def self.load_stations
    source = GTFS::Source.build("http://media.metro.net/developer/gtfs/google_transit.zip", {strict: false})
    stations = Array.new

    # Filter and select Metro Rail stops, first mention only
    # TODO: Test ^8\d{4}S
    stations = source.stops.select {|stops| stops.id=~/^8\d{4}$/}
    # Returns @id, @code, @name, @lat, @lon, @location_type, @parent_station

    # Save each station with name and number attributes
    stations.each do |station|
        @station = self.new
        @station.name   = station.name
        @station.number = station.id
        @station.location = {:lat => station.lat, :lon => station.lon}
        @station.status = true
        @station.save
      end
  end

  # TODO: Add established_at
end

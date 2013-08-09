class Station
  include MongoMapper::Document

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
    # Convert @lat @lon to Hash key:value pair and convert to float
    stations.each do |station|
        @station = self.new
        @station.name   = station.name
        @station.number = station.id
        @station.location = {:lat => station.lat.to_f, :lon => station.lon.to_f}
        @station.status = true
        @station.save
      end
  end
  # TODO: Does this run every time I load the website? Or just once?
  # TODO: Add established_at
end

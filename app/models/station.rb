class Station
  include MongoMapper::Document
  require 'open-uri'

  many :datapoints

  key :name, String
  key :number, String

  key :lat, Float
  key :lon, Float

  key :status, Boolean
  key :established_at, Date

  key :fips, String

  def self.get_fips(lat, lon)
    url = "http://data.fcc.gov/api/block/2010/find?format=json&latitude=#{lat}&longitude=#{lon}&showall=false"
    JSON.parse(open(url).read)["Block"]["FIPS"]
  end

  def self.load_stations
    source = GTFS::Source.build("http://media.metro.net/developer/gtfs/google_transit.zip", {strict: false})
    stations = Array.new

    # Add hash to array; Filter and select Metro Rail stops, first mention only
    # TODO: Test ^8\d{4}Ss
    stations = source.stops.select {|stops| stops.id=~/^8\d{4}$/}
    # Returns @id, @code, @name, @lat, @lon, @location_type, @parent_station

    # Save each station with name and number attributes
    stations.each do |station|
        @station        = Station.new
        @station.name   = station.name
        @station.number = station.id
        @station.lat    = station.lat.to_f
        @station.lon    = station.lon.to_f
        @station.fips   = get_fips(station.lat, station.lon)[5..11]
        @station.status = true
        @station.save
      end
  end
  # TODO: Does this run every time I load the website? Or just once?
  # TODO LATER: Add established_at
end

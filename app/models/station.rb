class Station
  include MongoMapper::Document
  require 'open-uri'

  many :datapoints

  key :name, String
  key :number, String

  key :lat, Float
  key :lon, Float

  key :status, Boolean
  # key :established_at, Date

  key :fips, String

  ## Set Census API keys and subject, name
  API_KEY = "3e8ce116910ba1a14b123c7b410d00be1656e54a"
  ## Median Income table and average row
  ## B19013_001 Median Household Income In The Past 12 Months (In 2010 Inflation-Adjusted Dollars)
  SUBJECT = "B19013_001E"
  DATASET = 'acs5'
  YEAR = 2010
  ## State - California
  STATE = "06"
  ## County - Los Angeles
  COUNTY = "037"

  # Get FIPS from Lat, Lon
  def self.get_fips(lat, lon)
    get_url = "http://data.fcc.gov/api/block/2010/find?format=json&latitude=#{lat}&longitude=#{lon}&showall=false"
    JSON.parse(open(get_url).read)["Block"]["FIPS"]
  end

  # Get Data Point from FIPS
  def self.get_census(fips)
    get_url = "http://api.census.gov/data/2010/#{DATASET}?key=#{API_KEY}&get=#{SUBJECT},NAME&for=tract:#{fips}&in=state:#{STATE}+county:#{COUNTY}"
    JSON.parse(open(get_url).read)[1][0]
  end

  # Load stations
  def self.load_stations
    source = GTFS::Source.build("http://media.metro.net/developer/gtfs/google_transit.zip", {strict: false})
    stations = Array.new

    # Add hash to array; Filter and select Metro Rail stops, first mention only
    # TODO: Test ^8\d{4}Ss
    stations = source.stops.select {|stops| stops.id=~/^8\d{4}$/}
    # Returns @id, @code, @name, @lat, @lon, @location_type, @parent_station

    # Save each station with name and number attributes
    stations.each do |station|
        @station            = Station.new
        @station.name       = station.name
        @station.number     = station.id
        @station.lat        = station.lat.to_f
        @station.lon        = station.lon.to_f
        @station.fips       = get_fips(station.lat, station.lon)[5...11]
        @station.datapoints << Datapoint.new(point: get_census(@station.fips), year: "#{YEAR}", subject: "#{SUBJECT}")
        @station.status     = true
        @station.save
    end
  end
  # TODO: Does this run every time I load the website? Or just once?
  # TODO LATER: Add established_at
end

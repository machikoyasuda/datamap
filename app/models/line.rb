class Line
  include MongoMapper::Document
  key :station_ids, Array
  many :stations, :in => :station_ids

  key :name, String
  key :number, String
  key :color, String

  def self.get_station(line)
    lookup = {
      801 => ["80106","80108","80109","80110","80111","80113","80114","80115","80116","80101","80153","80102","80154","80105","80107","80112","80117","80118","80119", "80120"],
      802 => ["80214","80213","80212","80211","80210","80209","80208","80207","80206","80205","80204","80203","80202", "80201"],
      803 => ["80314","80313","80312","80311","80310","80309","80308","80307","80306","80305","80304","80303","80302", "80301"],
      804 => ["80409","80410","80411","80412","80413","80414","80415","80416","80417","80418","80419","80420","80421","80408","80407","80406","80405","80404","80403","80402", "80401"],
      805 => ["80214","80213","80212","80211","80210","80209","80215", "80216"],
      806 => ["80121","80122","80123","80124","80125","80126","80127","80128","80129","80130","80131", "80132"]
    }
    array = Array.new
    line_station_numbers = lookup[line.to_i]
    line_station_objects = Station.all(:number => line_station_numbers)
    line_station_objects.each do |object|
      array << object.id
    end
    array
    line_station_objects
  end

  def self.load_lines
    source = GTFS::Source.build("http://media.metro.net/developer/gtfs/google_transit_2013-08-15.zip", {strict: false})

    # Select Metro Rail only, then delete repeats
    routes = source.routes.select { |line| line.id =~/^80/}
    lines = routes.uniq { |route| route.long_name }

    # Save each line with name and number attributes
    lines.each do |line|
        @line               = Line.new
        prepend             = "#"
        @line.color         = prepend + line.color
        @line.name          = line.long_name[6..-8]
        @line.number        = line.id[0..2]
        x      = get_station(@line.number)
        @line.stations = x
        @line.save
      end
  end
end

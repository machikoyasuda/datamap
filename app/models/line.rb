class Line
  include MongoMapper::Document
  many :stations, :in => :station_ids

  key :name, String
  key :number, String

  def self.load_lines
    source = GTFS::Source.build("http://media.metro.net/developer/gtfs/google_transit.zip", {strict: false})
    lines = Array.new

    # Filter and select Metro Rail only
    lines = source.routes.select {|routes| routes.id =~/^80/}
    # Returns @id, @long_name, @type, @color, @text_color

    # Save each line with name and number attributes
    lines.each do |line|
        @line = self.new
        @line.name   = line.long_name
        @line.number = line.id
        # Regex (801)(.*) or ^801\d{2}$?
        # @line.stations = Station.where(station.number.regex { field: {$regex: '(801)(.*) '} } == line.number (first 3)
        # TODO: Station.all(:number => /(801)(.*)/) = line.number
        # TODO: Add Station.id where Station.all matches first 3 numbers of Line.id
        @line.save
      end
  end
end

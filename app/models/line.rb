class Line
  include MongoMapper::Document
  many :stations

  key :name, String
  key :number, String

  def self.load_lines
    source = GTFS::Source.build("http://media.metro.net/developer/gtfs/google_transit.zip", {strict: false} )
    lines = Array.new

    # Filter and select Metro Rail only
    lines = source.routes.select {|routes| routes.id =~/^80/}
    # Returns @id, @long_name, @type, @color, @text_color

    # Save each line with name and number attributes
    lines.each do |line|
        @line = self.new
        @line.name   = line.long_name
        @line.number = line.id
        @line.save
      end
  end
end

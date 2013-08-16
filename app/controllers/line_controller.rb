class LineController < ApplicationController
  def stats
    # Return JSON
    # create Array of Arrays
    @stations = Array.new
    @data = Hash.new

    # Find each station, put name and datapoint into Hash, add to Array
    Station.find_each(:number => /(804)(.*)/) do |x|
      @data = { "station" => x.name, "datapoint" => x.datapoints[0].point}
      @stations << @data
    end

    # TODO: Need to DRY RegEx for station lines
    # TODO: Need to DRY datapoints[0]
    # Write code to load JSON of the Line with params[:id]
    render json: stats
  end
end

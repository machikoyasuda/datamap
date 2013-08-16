class LineController < ApplicationController
  def stats
    # Return JSON
    # create Array of Arrays
    @stations = Array.new
    @data = Hash.new

    # Find a Line and all of its stations, put name and datapoint into Hash, add to Array
    Line.find_by_name('Gold Line').stations.each do |x|
      @data = { "station" => x.name, "datapoint" => x.datapoints[0].point}
      @stations << @data
    end

    # Write code to load JSON of the Line with params[:id]
    render json: stats
  end
end

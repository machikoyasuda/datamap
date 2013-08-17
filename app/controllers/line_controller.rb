class LineController < ApplicationController
  def stats
    # Data: create Array of Arrays
    @stations = Array.new
    @data = Hash.new

    # TODO: Put AJAX clicked id into find_by_name
    # Find a Line and all of its stations, format data into Hash, add to Array
    Line.find_by_id(params[:id]).stations.each do |x|
      @data = { "station" => x.name, "datapoint" => x.datapoints[0].point}
      @stations << @data
    end

    # Render JSON for AJAX request
    render json: @stations
  end
end

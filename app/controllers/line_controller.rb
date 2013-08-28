class LineController < ApplicationController
  def stats
    # Pass in function to each station of that Line
    # For each station at a specific Line
    # Create hash of name and datapoint
    @stations = Line.find_by_id(params[:id]).stations.map do |station|
      { "station" => station.name, "datapoint" => station.datapoints[0].point}
    end

    # Render JSON for AJAX request
    render json: @stations

    # TODO: DRY up Datapoints
  end

  def download
    @lines = Line.all
    @stations = Array.new
    @data = Hash.new

    # Create JSON
    @lines.each do |line|
      line.stations.each do |station|
        @data = { "line" => line.name, "station" => station.name, "datapoint" => station.datapoints[0].point}
        @stations << @data
      end
    end

    # Render JSON
    render json: @stations

    # TODO: Create CSV and Spreadsheets
  end
end

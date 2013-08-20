class LineController < ApplicationController
  def stats
    # Data: create Array of Arrays
    @stations = Array.new
    @data = Hash.new

    # Find a Line and all of its stations, format data into Hash, add to Array
    Line.find_by_id(params[:id]).stations.each do |station|
      @data = { "station" => station.name, "datapoint" => station.datapoints[0].point}
      @stations << @data
    end

    # Render JSON for AJAX request
    render json: @stations
  end

  def download
    require 'csv'

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
  end
end

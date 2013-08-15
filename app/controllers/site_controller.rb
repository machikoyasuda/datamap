class SiteController < ApplicationController
  def index
    # create Array of Arrays
    @stations = Array.new
    @station = Hash.new

    # Find each station, put name and datapoint into Hash, add to Array
    Station.find_each(:number => /(804)(.*)/) do |x|
      @station = { "Station" => x.name, "Datapoint" => x.datapoints[0].point}
      @stations << @station
    end

    # TODO: Need to DRY RegEx for station lines
    # TODO: Need to DRY datapoints[0]
  end
end

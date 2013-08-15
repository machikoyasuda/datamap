require "spec_helper"

describe Station do
  let(:station) { Station.new }

  describe "attributes" do
    it "has a name" do
      station.name = "Pacific Coast Hwy Station"
      expect(station.name).to eql "Pacific Coast Hwy Station"
    end

    it "has a number" do
      station.number = "80106"
      expect(station.number).to eql "80106"
    end

    it "has a lat" do
      station.lat = "33.78909"
      expect(station.lat).to eql 33.78909
    end

    it "has a lon" do
      station.lon = "-118.189382"
      expect(station.lon).to eql -118.189382
    end

    it "has a status" do
      station.status = "true"
      expect(station.status).to eql true
    end

    it "has a fips" do
      station.fips = "get_fips(station.lat, station.lon)[5...11]"
      expect(station.fips).to eql "get_fips(station.lat, station.lon)[5...11]"
    end

    it "has a census datapoint embedded in it" do
      station.datapoints[0].point = 28782
      expect(station.datapoints[0].point).to eql 28782
    end

  end
end

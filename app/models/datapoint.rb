class Datapoint
  include MongoMapper::EmbeddedDocument

  key :subject, String
  key :point, Float
  key :year, Date

  ## Set Census API keys and subject, name
  API_KEY = "3e8ce116910ba1a14b123c7b410d00be1656e54a"
  ## Median Income table and average row
  ## B19013_001 Median Household Income In The Past 12 Months (In 2010 Inflation-Adjusted Dollars)
  SUBJECT = "B19013_001E"
  ## State - California
  STATE = "06"
  ## County - Los Angeles
  COUNTY = "037"
  ## Tract
  ## tract = "576001"

  ## http://api.census.gov/data/2010/acs5?key=3e8ce116910ba1a14b123c7b410d00be1656e54a&get=B19013_001E,NAME&for=tract:576001&in=state:06+county:037

  def self.load_census(fips)
    url = "http://api.census.gov/data/2010/acs5?key=#{API_KEY}&get=#{SUBJECT},NAME&for=tract:#{TRACT}&in=state:#{STATE}+county:#{COUNTY}"
    JSON.parse(open(url).read)[1][0]
    datapoint.
  end

end
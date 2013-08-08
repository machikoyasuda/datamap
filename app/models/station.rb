class Station
  include MongoMapper::Document
  belongs_to :line
  many :datapoints

  key :name, String
  key :number, Integer
  key :status, Boolean
  key :established_at, Date
  key :location, Hash

end

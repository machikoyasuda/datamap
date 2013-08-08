class Line
  include MongoMapper::Document
  many :stations

  key :name, String
  key :number, Integer

end

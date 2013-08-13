class Datapoint
  include MongoMapper::EmbeddedDocument

  key :subject, String
  key :point, Float
  key :year, Date

end
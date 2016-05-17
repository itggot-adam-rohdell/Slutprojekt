class Info
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :text, Text
  property :date, DateTime


  belongs_to :user

end
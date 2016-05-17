class Ticket
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :text, Text
  property :date, DateTime, default: Time.now

  has n, :tfiles
  belongs_to :category
  belongs_to :user
end
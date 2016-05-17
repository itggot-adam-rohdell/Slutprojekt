class Tfile
  include DataMapper::Resource

  property :id, Serial
  property :ticket_hash, String
  property :path, String
  property :size, Integer

  belongs_to :ticket
end
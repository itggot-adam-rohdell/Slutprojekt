class Question
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :answer, Text

  has n, :qfiles
  belongs_to :category
end
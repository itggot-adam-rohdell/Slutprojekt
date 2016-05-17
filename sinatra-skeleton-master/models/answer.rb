class Answer
  include DataMapper::Resource

  property :id, Serial
  property :text, Text
  property :date, DateTime, default: Time.now

  belongs_to :user
  has n, :tfiles
end
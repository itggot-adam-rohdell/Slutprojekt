class Qfile
  include DataMapper::Resource

  property :id, Serial
  property :question_hash, String
  property :path, String
  property :size, Integer

  belongs_to :question

end
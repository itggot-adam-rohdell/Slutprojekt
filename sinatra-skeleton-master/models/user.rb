class User
  include DataMapper::Resource

  property :id, Serial
  property :name, String, :required => true
  property :password, String, :required => true
  property :mail, String
  property :last_login, DateTime
  property :admin, Boolean
  property :session_id, String


  has n, :infos
  has n, :tickets

end
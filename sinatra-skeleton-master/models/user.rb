class User
  include DataMapper::Resource

  property :id, Serial
  property :name, String, :required => true
  property :password, String, :required => true
  property :mail, String
  property :last_login, DateTime
  property :session_id, String
  property :type, Discriminator


  def admin?
    self.is_a? AdminUser
  end


end

class AdminUser < User
  has n, :infos
  has n, :tickets

end

class WebbUser < User
  has n, :tickets

end



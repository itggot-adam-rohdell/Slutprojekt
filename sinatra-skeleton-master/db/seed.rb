class Seeder

  def self.seed!
    self.make_category!
    self.make_user!
  end

  def self.make_category!
    Category.create :name => 'Användarnamn'
    Category.create :name => 'Dator'
    Category.create :name => 'Inloggning'
    Category.create :name => 'Email'
    Category.create :name => 'Övrigt'
  end

  def self.make_user!
    User.create :name => 'jocke', :password => 'kappa123', :mail => 'kappa@gmail.com', :last_login => Time.now, :admin => true
  end

end

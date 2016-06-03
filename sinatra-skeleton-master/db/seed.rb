class Seeder

  def self.seed!
    self.make_category!
    self.make_user!
    self.make_question!
  end

  def self.make_category!
    Category.create :name => 'Användarnamn'
    Category.create :name => 'Dator'
    Category.create :name => 'Inloggning'
    Category.create :name => 'Email'
    Category.create :name => 'Övrigt'
  end

  def self.make_user!
    AdminUser.create :name => 'jocke', :password => 'kappa123', :mail => 'kappa@gmail.com', :last_login => Time.now
    WebbUser.create :name => 'yusif', :password => 'keepo', :mail => 'kappa@gmail.com', :last_login => Time.now
  end


  def self.make_question!
    Question.create :title => 'Hur blir jag administratör på min dator?', :answer => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', :category_id => 2
    Question.create :title => 'Hur blir jag av med Josef?!?!?!', :answer => 'Ledsen grabben, Josef blir man inte av med', :category_id => 3
  end

end

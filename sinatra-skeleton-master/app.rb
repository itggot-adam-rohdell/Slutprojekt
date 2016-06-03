class App < Sinatra::Base
  enable :sessions

  get '/' do
    @user = User.first(id: session[:user_id])
  	erb :home

  end

  get '/login' do
    erb :login
  end

  before do
    @user = User.first(id: session[:user_id])
   if request.path_info == '/' || request.path_info == '/login' || request.path_info == '/favicon.ico'
     if session[:redirecterino] && request.path_info != '/login'
       href = session[:redirecterino]
       p "href is #{href} and keepo is #{session[:redirecterino]}"
       session[:redirecterino] = nil
       redirect href
     end
   else
    if session.has_key?(:user_id)
      unless @user
        session[:redirecterino] = request.path_info
        p session
        redirect "/login"
      end
    else
      session[:redirecterino] = request.path_info
      p session
      redirect "/login"
    end
   end
  end

  get '/ask' do
    @user = User.first(id: session[:user_id])
    erb :ask
  end


  post '/login' do
    user = User.first( :name => params[:username].downcase)
    if user
      if user.password == params[:password]
        session[:user_id] = user.id
        redirect "/"
      else
        redirect "/login#invalid_login"
      end
    else
      redirect "/login#invalid_login"
    end
  end


  post '/ask' do
    cat = Category.first(:id => params[:category])
    p cat
    if params[:title].length > 0 && params[:text].length > 0 && cat
      ticket = Ticket.create :title => params[:title], :text => params[:text], :webb_user_id => session[:user_id], :category => cat
      p ticket
      ticket.save
      redirect "/#{session[:user_id]}/tickets/#{ticket.id}"
    else
      redirect "/ask#missing_field"
    end
  end

  get '/logout' do
    session.destroy
    redirect '/'
  end

  get '/faq' do
    @questions = Question.all
    erb :questions
  end

  get "/:user_id/tickets/?" do |user_id|
    @target_user = User.first(id: params[:user_id])
    if @target_user && @user && @target_user.id == @user.id || @user.admin?
      @tickets = Ticket.all(:webb_user_id => user_id)
      erb :tickets
    else
      redirect '/#not_allowed'
    end
  end

  get "/:user_id/tickets/:ticket_id/?" do

    @target_user = User.first(id: params[:user_id])
    if @target_user.id == @user.id || @user.admin?
      @ticket = Ticket.first(:id => params[:ticket_id])
      erb :ticket_user
    else
     redirect '/#not_allowed'
    end
  end

  before '/admin/?*' do
    unless @user.admin?
      redirect '/'
    end
  end

  get "/admin/admins/:user_id" do
    @admin = User.first(:id => params[:user_id])
    erb :admin_id
  end

  get '/admin/unsolved/tickets' do
    @admin_tickets = Ticket.all(:admin_user => '')
    erb :admin_tickets
  end


  post '/admin/unsolved/tickets/assigned' do
    params[:admin_user_id]
    admin = AdminUser.get(params[:admin_user_id])
    if admin
      ticket = Ticket.get(params[:ticket_id])
      if ticket
        ticket.admin_user = admin
        ticket.save
        return 'ok'
      end
    end
    'err'
  end

  ## This is where all the admin stuff happens
  #  Everything that requires admin rights is checked in the code right below here
  #  Checking admin status with /admin and then putting all other hrefs after /admin
  get '/admin/admins' do
    @admins = AdminUser.all(:order => [:name.desc])
    erb :admins
  end

  get '/admin/admin_panel' do
    erb :admin_panel
  end

  get '/admin/users' do
    @users = User.all(:order => [ :name.desc ])
    erb :users
  end

  get '/admin/my_tickets' do
    @tickets = Ticket.all(:admin_user_id => session[:user_id])
    erb :my_admin_tickets
  end


  get "/admin/:user_id/:user_name" do
    @target_user = User.first(:id => params[:user_id])
    @tickets = Ticket.all(:webb_user_id => params[:user_id])
    p @target_user
    erb :target_user
  end

  get '/admin/faq' do
    erb :make_faq
  end

  post '/admin/make_faq' do
    cat = Category.first(:id => params[:category])
    if params[:title].length > 0 && params[:answer].length > 0 && cat
      faq = Question.create :title => params[:title], :answer => params[:answer], :category => cat
      faq.save
      redirect '/faq'
    else
      redirect "/faq#missing_field"
    end
  end

  before '/tetris.png' do
    unless @user.admin?
      redirect '/'
    end
  end

end
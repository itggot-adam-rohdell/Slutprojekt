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
   if request.path_info == '/' || request.path_info == '/login'
     if session[:redirecterino] && request.path_info != '/login'
       href = session[:redirecterino]
       p "href is #{href} and keepo is #{session[:redirecterino]}"
       session[:redirecterino] = nil
       redirect href
     end
   else
    if session.has_key?(:user_id)
      @user = User.first(id: session[:user_id])
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

  get '/admins' do
    @admins = User.all(:admin => true)
    erb :admins
  end

  get "/admins/:user_id" do
    @admins = User.all(:admin => true)
    erb :admin_id
  end

  post '/login' do
    user = User.first( :name => params[:username])
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
      ticket = Ticket.create :title => params[:title], :text => params[:text], :user_id => session[:user_id], :category => cat
      p ticket
      redirect "/#{session[:user_id]}/tickets/#{ticket.id}"
    else
      redirect "/ask#missing_field"
    end
  end

  get '/logout' do
    session.destroy
    redirect '/'
  end

  get '/questions' do
    @questions = Question.all
  end

  get "/:user_id/tickets/?" do |user_id|
    @user = User.first(id: session[:user_id])
    @tickets = Ticket.all(:user_id => user_id)
    erb :tickets
  end

  get "/:user_id/tickets/:ticket_id/?" do
    @user = User.first(id: session[:user_id])
    @ticket = Ticket.first(:id => params[:ticket_id])
    erb :ticket_user
  end



end
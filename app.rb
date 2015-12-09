require('bundler')
Bundler.require

ActiveRecord::Base.establish_connection(
  :adapter => 'postgresql',
  :database => 'security_pract_dev'
)

enable :sessions

set :views, File.expand_path('../views', __FILE__)

# define a few session helps
def get_current_user_if_exists
  if session[:user]
    return session[:user]
  else
    return nil
  end
end

def log_current_user_out
  if get_current_user_if_exists == nil
    return false
  else
    session[:user] = nil
    return true
  end
end

# routes
get '/' do
  # some content
  # binding.pry
  erb :hotstuff
end

get '/logout' do
  # clear our session
  # redirect home
  log_current_user_out
  redirect '/'
end

get '/foyer' do
  # present user with a form to login
  # or a form to register
  erb :foyer
end

post '/login' do
  # check params
  # validate password
  # log user in
  # redirect home
  # add message to session to welcome user
end

post '/register' do
  # check params
  # validate password
  # log user in
  # redirect home
  # add message to session to thank user for registering
end

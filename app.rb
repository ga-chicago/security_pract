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

def set_current_user_and_login(user_object)
  session[:user] = user_object
end

def log_current_user_out
  if get_current_user_if_exists == nil
    return false
  else
    session[:user] = nil
    return true
  end
end

def set_app_message(message_text)
  session[:message] = message_text
end

def get_app_message
  return session[:message]
end

def clear_app_message
  session[:message] = nil
end
# end helpers

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
  attempt = Account.authenticate(params[:username], params[:password])
  # log user in
  set_current_user_and_login(attempt)
  # redirect home
  binding.pry
  redirect '/'
end

post '/register' do
  # check params
  # expect: `username`, `password`
  attempt = Account.register(params[:username], params[:password])
  # validate password
  # add message to session to thank user for registering
  if (attempt == false)
    set_app_message('A problem occured during registration. Please check yoself.')
    # womp womp, reload view with error
  else
    # log user in
    #set_app_message('Thank you, you are registered')
    set_current_user_and_login(attempt)
  end
  # redirect home
  redirect '/'
end

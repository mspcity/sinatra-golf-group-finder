require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set:session_secret, "secret"
  end

  get '/' do
    erb :main
  end



  get '/signup' do
    if Helpers.is_logged_in?(session)
      redirect to '/schedules'
    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    if params[:username].blank?
      redirect to '/signup'
    elsif params[:password].blank?
      redirect to '/signup'
    else
      @user = User.create(username: params[:username], password: params[:password])
      session[:user_id] = @user.id

      redirect to 'schedules/new'
    end
  end

  get '/login' do
    if Helpers.is_logged_in?(session)
      redirect to '/schedules'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id

      redirect to '/schedules'
    else
      redirect to '/login'
    end
  end

  get '/logout' do
    session.clear

    redirect to '/login'
  end
end

require "./config/environment"

class ApplicationController < Sinatra::Base

    configure do
      enable :sessions
      set :public_folder, "public"
      set :views, "app/views"
      set :session_secret, "secret"
    end

    get '/' do
      erb :index
    end

    def is_logged_in?
      !!active_user
    end

    def active_user
      @active_user ||= User.find(session[:user_id]) if session[:user_id]
    end

end
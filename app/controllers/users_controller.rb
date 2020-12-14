class UsersController < ApplicationController

    # sign up - get
    get '/signup' do 
        if is_logged_in?
            # todo - redirect the user to their page using their id
        else
            erb :'/users/user_create'
        end
    end

    # sign up - post
    post '/signup' do
        # create a new user from the filled out form
        @new_user = User.new(username: params[:username].strip, email: params[:email].strip, password: params[:password].strip)

        # todo - this could use some refactoring so that we're validating that all the info has been filled out correctly.
        @new_user.save
        
        # user isn't nil, then redirect to the main page
        if !@new_user.nil?

            #assign the session id from the newly created and saved user.
            session[:user_id] = @new_user.id

            redirect to '/'
        else
            # take them back to the login page
            redirect to '/login'
        end
    end


    # login - get
    get '/login' do
        if is_logged_in?

            # todo - make this page
            # redirect to "/users/#{current_user.id}"
          else
            # todo - make this page
            erb :'/users/user_login'
          end
    end

    # login - post
    post '/login' do
        @user = User.find_by(username: params[:username].strip, password: params[:password].strip)

        binding.pry
        # if the user is not nil, then send them to the home page
        if !@user.nil?
            session[:user_id] = @user.id
            redirect to '/'
        else
            # take them back / keep them on the login page
            redirect to '/login'
        end
    end


    # log out - get
    get '/logout' do
        if is_logged_in?
            # if we're logged in then clear the session to put is in a logged out state
            session.clear
            redirect to '/'
        else
            redirect to '/'
        end
    end

end
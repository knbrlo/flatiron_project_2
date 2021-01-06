class UsersController < ApplicationController

    get "/signup" do 
        if is_logged_in?
            redirect to "/"
        else
            erb :"/users/create"
        end
    end

    post "/signup" do

        #todo - don't let them sign up with nil values.


        # create a new user from the filled out form
        @new_user = User.new(username: params[:username].strip, email: params[:email].strip, password: params[:password].strip)
        
        
        @new_user.save
        
        # user isn't nil, then redirect to the main page
        if !@new_user.nil?

            #assign the session id from the newly created and saved user.
            session[:user_id] = @new_user.id

            # todo - redirect to their account.
            redirect to "/"
        else
            # take them back to the login page
            redirect to "/login"
        end
    end

    get "/login" do
        if is_logged_in?
            redirect to "/users/#{active_user.id}"
          else
            erb :"/users/login"
          end
    end

    post "/login" do

        user = User.find_by(username: params[:username])

        if user && user.authenticate(params[:password]) 

            session[:user_id] = user.id
            redirect to "/notes"
        else
            # todo - make sure to remove notes when ready to submit
            # take them back / keep them on the login page
            redirect to "/login"
        end
    end

    get "/users/:id" do
        
        # get the user
        @user = User.find_by_id(params[:id])

        # make sure they're logged in and the id of the page is equal to the active user
        if is_logged_in? && @user == active_user
            erb :"/users/show"
        else
            redirect to "/login"
        end

    end

    get "/users/:id/edit" do
        
        # get the user
        @user = User.find_by_id(params[:id])

        # make sure they're logged in and the id of the page is equal to the active user
        if is_logged_in? && @user == active_user

            erb :"/users/edit"
        else
            redirect to "/login"
        end

    end

    patch "/users/:id" do

        # get all of the changes and assign them to the user
        @user = User.find_by_id(params[:id])
        
        # make sure they're logged in, they are the user they're trying
        # to edit
        if is_logged_in? && @user == active_user
            @user.username = params[:username].strip
            @user.email = params[:email].strip
            @user.password = params[:password].strip
            @user.save
            redirect to "/users/#{@user.id}"
        else
            redirect to "/login"
        end
    end

    get "/logout" do
        if is_logged_in?
            # if we're logged in then clear the session to put is in a logged out state
            session.clear
            redirect to "/"
        else
            redirect to "/"
        end
    end

    delete "/users/:id" do

        # get the currently logged in user
        @user = User.find_by_id(params[:id])

        # make sure they're logged in and they are the user
        # that they're trying to delete
        if is_logged_in? && @user == active_user

            # delete their account
            @user.delete

            # now that they're deleted clear the session and send
            # them to the home page
            session.clear

            redirect to "/"
        else
            redirect to "/login"
        end
    end

end
class UsersController < ApplicationController

    # sign up - get
    get "/signup" do 
        if is_logged_in?
            # todo - redirect the user to their page using their id
        else
            erb :"/users/user_create"
        end
    end

    # sign up - post
    post "/signup" do
        # create a new user from the filled out form
        @new_user = User.new(username: params[:username].strip, email: params[:email].strip, password: params[:password].strip)

        # todo - this could use some refactoring so that we're validating that all the info has been filled out correctly.
        @new_user.save
        
        # user isn't nil, then redirect to the main page
        if !@new_user.nil?

            #assign the session id from the newly created and saved user.
            session[:user_id] = @new_user.id

            redirect to "/"
        else
            # take them back to the login page
            redirect to "/login"
        end
    end


    # login - get
    get "/login" do
        if is_logged_in?
            redirect to "/users/#{active_user.id}"
          else
            erb :"/users/user_login"
          end
    end

    # login - post
    post "/login" do
        @user = User.find_by(username: params[:username].strip, password: params[:password].strip)

        # if the user is not nil, then send them to the home page
        if !@user.nil?
            session[:user_id] = @user.id
            redirect to "/"
        else
            # take them back / keep them on the login page
            redirect to "/login"
        end
    end


    # profile - get
    get "/users/:id" do
        
        # get the user
        @user = User.find_by_id(params[:id])

        # make sure they're logged in and the id of the page is equal to the active user
        if is_logged_in? && @user == active_user
            erb :"/users/user_profile"
        else
            redirect to "/login"
        end

    end

    # profile edit - get
    get "/users/:id/edit" do
        
        # get the user
        @user = User.find_by_id(params[:id])

        # make sure they're logged in and the id of the page is equal to the active user
        if is_logged_in? && @user == active_user
            # todo -  would be nice to show a message here that it was saved successfully.
            erb :"/users/user_edit"
        else
            redirect to "/login"
        end

    end

    # profile edit - patch
    patch "/users/:id" do

        # get all of the changes and assign them to the user
        @user = User.find_by_id(params[:id])
        @user.username = params[:username].strip
        @user.email = params[:email].strip
        @user.password = params[:password].strip

        # make sure they're logged in, they are the user they're trying
        # to edit
        if is_logged_in? && @user == active_user
            @user.save
            redirect to "/users/#{@user.id}"
        else
            redirect to "/login"
        end
    end


    # log out - get
    get "/logout" do
        if is_logged_in?
            # if we're logged in then clear the session to put is in a logged out state
            session.clear
            redirect to "/"
        else
            redirect to "/"
        end
    end

    # delete
    delete "/users/:id" do

        # get the currently logged in user
        @user = User.find_by_id(params[:id])

        # make sure they're logged in and they are the user
        # that they're trying to delete
        if is_logged_in? && @user == active_user

            # todo - delete their providers they're signed up with

            # todo - delete their shows they're watching.

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
class UsersController < ApplicationController

    get "/signup" do 
        if is_logged_in?
            redirect to "/"
        else
            erb :"/users/create"
        end
    end

    post "/signup" do
        @new_user = User.new(username: params[:username].strip, email: params[:email].strip, password: params[:password].strip)
        @new_user.save
        if !@new_user.nil?
            session[:user_id] = @new_user.id
            redirect to "/"
        else
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
            redirect to "/login"
        end
    end

    get "/users/:id" do
        @user = User.find_by_id(params[:id])
        if is_logged_in? && @user == active_user
            erb :"/users/show"
        else
            redirect to "/login"
        end
    end

    get "/users/:id/edit" do
        @user = User.find_by_id(params[:id])
        if is_logged_in? && @user == active_user
            erb :"/users/edit"
        else
            redirect to "/login"
        end
    end

    patch "/users/:id" do
        @user = User.find_by_id(params[:id])
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
            session.clear
            redirect to "/"
        else
            redirect to "/"
        end
    end

    delete "/users/:id" do
        @user = User.find_by_id(params[:id])
        if is_logged_in? && @user == active_user
            @user.delete
            session.clear
            redirect to "/"
        else
            redirect to "/login"
        end
    end
end
class NotesController < ApplicationController

    get '/notes' do
        if is_logged_in?
            @all_notes = Note.where("user_id = #{active_user.id}").order("created_at desc")
            @user = User.find_by_id(active_user.id)
            erb :"/notes/index"
        else
            redirect to "/"
        end
    end

    get '/notes/all' do
        @all_notes = Note.all
        erb :"/notes/all"
    end

    get '/notes/create' do
        if is_logged_in?
            erb :"/notes/create"
        else
            redirect to "/"
        end
    end

    post "/notes" do
         if is_logged_in?
            @post_title = params[:title].strip
            @post_content = params[:content].strip
            @new_post = Note.new(title: @post_title, content: @post_content, user_id: active_user.id)
            @new_post.save
            redirect to "/notes/#{@new_post.id}"
        else
            redirect to "/"
        end
    end

    get '/notes/:id' do
        @note = Note.find_by_id(params[:id])
        if is_logged_in? && !@note.nil? && (@note.user_id == active_user.id)
            erb :"/notes/show"
        else
            redirect to "/"
        end
    end

    get '/notes/:id/edit' do
        @note = Note.find_by_id(params[:id])
        if is_logged_in? && (@note.user_id == active_user.id)
            erb :"/notes/edit"
        else
            redirect to "/"
        end

    end

    patch '/notes/:id' do
        @note = Note.find_by_id(params[:id])
        if is_logged_in? && !@note.nil? && (@note.user_id == active_user.id)
            @note.title = params[:title].strip
            @note.content = params[:content].strip
            @note.save
            redirect to "/notes/#{@note.id}"
        else
            redirect to "/"
        end
    end

    delete '/notes/:id' do
        @note = Note.find_by_id(params[:id])
        if is_logged_in? && !@note.nil? && (@note.user_id == active_user.id)
            @note.delete
            redirect to "/notes"
        else
            redirect to "/"
        end
    end
end
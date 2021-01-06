class NotesController < ApplicationController

    get '/notes' do
        p 'hello 1'
        if is_logged_in?
            @all_notes = Note.where("user_id = #{active_user.id}").order("created_at desc")
            @user = User.find_by_id(active_user.id)
            erb :"/notes/index"
        else
            redirect to "/"
        end
    end

    get '/notes/all' do
        p 'hello 2'
        @all_notes = Note.all
        erb :"/notes/all"
    end

    get '/notes/create' do
        p 'hello 3'
        if is_logged_in?
            erb :"/notes/create"
        else
            redirect to "/"
        end
    end

    post "/notes" do
        p 'hello 4'
         if is_logged_in?
            @post_title = params[:title].strip
            @post_content = params[:content].strip

            @new_post = Note.new(title: @post_title, content: @post_content, user_id: active_user.id)
            @new_post.save
            redirect to "/notes/#{@new_post.id}"
        else
            p 'hello 4.1'
            redirect to "/"
        end
    end

    get '/notes/:id' do
        p 'hello 5'
        @note = Note.find_by_id(params[:id])
        if is_logged_in? && !@note.nil? && (@note.user_id == active_user.id)
            erb :"/notes/show"
        else
            redirect to "/"
        end
    end

    get '/notes/:id/edit' do
        p 'hello 6'
        @note = Note.find_by_id(params[:id])
        if is_logged_in? && (@note.user_id == active_user.id)
            erb :"/notes/edit"
        else
            redirect to "/"
        end

    end

    patch '/notes/:id' do
        p 'hello 7'
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
        p 'hello 8'
        @note = Note.find_by_id(params[:id])
        if is_logged_in? && !@note.nil? && (@note.user_id == active_user.id)
            @note.delete
            redirect to "/notes"
        else
            redirect to "/"
        end
    end
end
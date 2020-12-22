class NotesController < ApplicationController

    get '/notes' do

        if is_logged_in?

            # query for all notes that have the same id as me.
            @all_notes = Note.where("user_id = #{active_user.id}")

            # get the user
            @user = User.find_by_id(active_user.id)

            erb :"/notes/index"
        else

            # take them back to the main page
            redirect to "/"
        end
    end

    get '/notes/create' do

        if is_logged_in?
            
            #take them to the new note creation page
            erb :"/notes/create"
        else

            # take them back to the main page
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

            # take them back to the main page
            redirect to "/"
        end
    end

    get '/notes/:id' do

        @note = Note.find_by_id(params[:id])

        # if they're logged in, if the note is not nil, 
        # if they are the owner then display the page.
        if is_logged_in? && !@note.nil? && (@note.user_id == active_user.id)

            erb :"/notes/show"
        else

            # take them back to the main page
            redirect to "/"
        end
    end

    #edit
    get '/notes/:id/edit' do

        @note = Note.find_by_id(params[:id])

        # if they're logged in, if they are the owner then display the page.
        if is_logged_in? && (@note.user_id == active_user.id)

            erb :"/notes/edit"
        else

            # take them back to the main page
            redirect to "/"
        end

    end

    patch '/notes/:id' do
        
        @note = Note.find_by_id(params[:id])

        # if they're logged in, if the note isn't nil and
        # if they are the owner then allow them to edit the note.
        if is_logged_in? && !@note.nil? && (@note.user_id == active_user.id)

            @note.title = params[:title].strip
            @note.content = params[:content].strip
            @note.save

            redirect to "/notes/#{@note.id}"
        else

            # take them back to the main page
            redirect to "/"
        end
    end

    delete '/notes/:id' do
        
        @note = Note.find_by_id(params[:id])

        # if they're logged in, if the note isn't nil and
        # if they are the owner then allow them to edit the note.
        if is_logged_in? && !@note.nil? && (@note.user_id == active_user.id)

            @note.delete

            redirect to "/notes"
        else

            # take them back to the main page
            redirect to "/"
        end

    end
end
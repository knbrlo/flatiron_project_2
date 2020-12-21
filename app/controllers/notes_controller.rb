class NotesController < ApplicationController


    # todo - char - user should have full crud over this.
    # 7 restful routes

    #new
    get '/notes/create' do

        # they can only create new notes if they're logged in
        if is_logged_in?
            
            #take them to the new note creation page
            erb :"/notes/create"
        else

            # take them back to the main page
            redirect to "/"
        end
    end


    #index
    get '/notes/:id' do

        # find the user id they've requested notes for
        @requested_notes_user = User.find_by_id(params[:id])

        # compare the userid they're requesting notes for against
        # the logged in user id
        if @requested_notes_user == active_user

            # query for all notes that have the same id as me.
            @all_notes = Note.where("user_id = #{active_user.id}")
            erb :"/notes/index"
        else
            
            # if they're trying to access someone else's notes 
            # take them back to the main page
            redirect to "/"
        end
    end




    # #create
    # post '/photos'

    # #show
    # get '/photos/:id'


    # #edit
    # get '/photos/:id/edit'

    # #update
    # put '/photos/:id'


    # #destroy
    # delete '/photos/:id'


end
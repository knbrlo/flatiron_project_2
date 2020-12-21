class NotesController < ApplicationController


    # todo - char - user should have full crud over this.
    # 7 restful routes

    #index
    get '/notes/:id' do

        # find the user id they've requested notes for
        @requested_notes_user = User.find_by_id(params[:id])

        # compare the userid they're requesting notes for against
        # the logged in user id
        if @requested_notes_user.id == active_user.id 

            # query for all notes that have the same id as me.
            @all_notes = Note.where("user_id = #{active_user.id}")
            erb :"/notes/index"
        else
            
            # if they're trying to access someone else's notes 
            # take them back to the main page
            redirect to "/"
        end
    end


    # #new
    # '/notes/new'
    get '/notes/new' do
        
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
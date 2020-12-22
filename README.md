# flatiron_project_2

# Nevernote

Nevernote is an online note keeping application with account sign up, account edit, account login, account logout that also includes the ability to create, edit, delete notes.

----

## Getting Started

Clone the repo

Run ```bundle install``` to install the required dependencies.

Run ```rake db:migrate``` to setup the database, create the tables, and the schema.

Run ```shotgun``` to start the server locally.

Open ```http://127.0.0.1:9393/``` in your browswer.


-----

## Sign up

Navigate to ```http://127.0.0.1:9393/``` and click the **Sign up for free** buttton on the home page, or click the **Sign Up** button in the top right of the page


-----
## Create a Note

Once logged in you'll be taken to the main notes page ```http://127.0.0.1:9393/notes``` where you'll have the ability to click on any note and have that displyed to the right along with a button to click that will allow you to edit it.

-----
## Edit a Note

Here on the edit page ```http://127.0.0.1:9393/notes/:id/edit``` there are options to change the title, content and save the changes or delete the note. If you save the changes you'll be taken to a note detail page, if you delete the note you'll be taken back to the notes index page.

-----
## Delete a Note

This is covered in the above text the controller will just handle the delete request after they've been authenticated one more time before processing the delete request.

-----
## Edit your account

This page can be accessed anywhere throughout the app once you've logged in click the **Account** selection in the header or navigate to ```http://127.0.0.1:9393/users/:id/```. Here you'll see your current username and email and below there's a button "Edit Account" where you can change your username, password, email address or if you're done with the app you can delete your account from here.

-----
## Delete your account

You can get to this page from the **Account** and then clicking on the **Edit Account** link or visit using the direct link which is ```http://127.0.0.1:9393/users/1/edit```. Here you can make changes to username, email or password. Also if you'd like to delete your account you can by clicking the light grey text at the bottom of the form.

### 
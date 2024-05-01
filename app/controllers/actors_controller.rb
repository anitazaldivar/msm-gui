class ActorsController < ApplicationController
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end

  def create
    # Retrieve user's inputs from params
     # params hash: 
    # Create a record in the actor table
    a = Actor.new

    # Populate each column with the user input
    a.name = params.fetch("the_name")
    a.dob = params.fetch("the_dob")
    a.bio = params.fetch("the_bio")
    a.image = params.fetch("the_image")
    
    # Save
    a.save

    # Redirect the user back to the /actors URL
    redirect_to("/actors", allow_other_host: true)
  end

  def destroy
    the_id = params.fetch("an_id")

    matching_records = Actor.where({ :id => the_id})

    the_actor = matching_records.at(0)

    the_actor.destroy

    redirect_to("/actors")
  end
end

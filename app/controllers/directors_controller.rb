class DirectorsController < ApplicationController
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end

  def create
    # Retrieve user's inputs from params
     # params hash: {"the_title"=>"1", "the_year"=>"3", "the_duration"=>"2", "the_description"=>"3", "the_image"=>"3", "the_director_id"=>"3"}

    # Create a record in the director table
    d = Director.new

    # Populate each column with the user input
    d.name = params.fetch("the_name")
    d.dob = params.fetch("the_dob")
    d.bio = params.fetch("the_bio")
    d.image = params.fetch("the_image")
    
    # Save
    d.save

    # Redirect the user back to the /movies URL
    redirect_to("/directors", allow_other_host: true)
  end

  def destroy
    the_id = params.fetch("an_id")

    matching_records = Director.where({ :id => the_id})

    the_director = matching_records.at(0)

    the_director.destroy

    redirect_to("/directors")
  end
end

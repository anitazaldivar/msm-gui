class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end

  def create
    # Retrieve user's inputs from params
     # params hash: {"the_title"=>"1", "the_year"=>"3", "the_duration"=>"2", "the_description"=>"3", "the_image"=>"3", "the_director_id"=>"3"}

    # Create a record in the movie table
    m = Movie.new

    # Populate each column with the user input
    m.title = params.fetch("the_title")
    m.year = params.fetch("the_year")
    m.duration = params.fetch("the_duration")
    m.description = params.fetch("the_description")
    m.image = params.fetch("the_image")
    m.director_id = params.fetch("the_director_id")
    
    # Save
    m.save

    # Redirect the user back to the /movies URL
    redirect_to("/movies", allow_other_host: true)
  end

  def destroy
    the_id = params.fetch("an_id")

    matching_records = Movie.where({ :id => the_id})

    the_movie = matching_records.at(0)

    the_movie.destroy

    redirect_to("/movies")
  end

  def update
    # Params hash: {"the_title"=>"", "the_year"=>"", "the_duration"=>"", "the_description"=>"", "the_image"=>"", "the_director_id"=>"", "an_id"=>"1"}
    # Get the ID out of params
    m_id = params.fetch("an_id")

    # Look the existing record
    matching_records = Movie.where({ :id => m_id})
    the_movie = matching_records.at(0)

    # Overwrite each column with values from user inputs
    the_movie.title = params.fetch("the_title")
    the_movie.year = params.fetch("the_year")
    the_movie.duration = params.fetch("the_duration")
    the_movie.description = params.fetch("the_description")
    the_movie.image = params.fetch("the_image")
    the_movie.director_id = params.fetch("the_director_id")

    # Save
    the_movie.save

    # Redirect to movie details page
    redirect_to("/movies/#{the_movie.id}")
  end
end

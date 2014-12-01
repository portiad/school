class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.select(:rating).map(&:rating).uniq

    @has_params = params[:ratings] != nil || params[:sort] != nil
    if @has_params
      session[:saved_params] = {}
      if (params[:sort] != nil)
        session[:saved_params][:sort] = params[:sort]
      end
      if (params[:ratings] != nil)
        session[:saved_params][:ratings] = params[:ratings]
      end
      
    elsif (session[:saved_params] != nil)
      flash.keep
      redirect_to movies_path + '?' + session[:saved_params].to_query
    end

    @sected_ratings = params[:ratings]
    @movies = Movie.find :all, :conditions => [ "rating IN (?)", params[:ratings] ? params[:ratings].keys : @all_ratings], :order => params[:sort]
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end

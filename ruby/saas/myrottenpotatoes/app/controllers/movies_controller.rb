class MoviesController < ApplicationController

  def show
    @movie = Movie.find(params[:id])
  end

  def index
    @movies = Movie.all
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def new
    #creates new template for entering in movie
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was created"
    redirect_to movie_path(@movie)
  end

  def update
    @movie = Movie.find(params[:id])
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was updated"
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "#{@movie.title} was deleted"
    redirect_to movies_path
  end
end

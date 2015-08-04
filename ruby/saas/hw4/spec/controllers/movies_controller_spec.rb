require "spec_helper"

describe MoviesController do
  let(:movie) { Movie.create(director: 'toto') }
  let(:tachatte) { Movie.create }

  before(:each) do
    movie
    3.times { Movie.create(director: 'toto') }
    3.times { Movie.create(director: 'non toto') }
  end

  describe "GET similar" do

    it "searches for the right movie" do
      Movie.should_receive(:find).with(movie.id.to_s).and_return(movie)
      get :similar, id: movie.id
    end

    it "searches for similar movies" do
      get :similar, id: movie.id
      assigns(:movies).should have(4).items
    end

    it "whoops" do
      get :similar, id: tachatte.id
    end
  end

  describe "GET index" do
    it "is ok" do
      get :index, sort: 'title'
    end

    it "is still ok" do
      get :index, sort: 'release_date', ratings: {'PG' => 1 }
    end

    it "is stupid" do
      get :index, ratings: {'G' => 1 }
    end

    it "is stupid again" do
      get :index
    end

    it "is still stupid" do
      get :index, ratings: { 'PG' => 1 }
    end
  end

  describe "GET show" do
    it "is ok" do
      get :show, id: 1
    end
  end

  describe "GET edit" do
    it "is ok" do
      get :edit, id: 1
    end
  end

  describe "POST index" do
    it "is ok" do
      post :create, movie: { title: 'tachatte' }
    end
  end

  describe "PUT movie" do
    it "is ok" do
      put :update, id: 1, movie: { title: 'tachatte' }
    end
  end

  describe "DELETE movie" do
    it "is ok" do
      delete :destroy, id: 1
    end
  end
end

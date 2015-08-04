require "spec_helper"

describe Movie do
  it "responds to similar_to" do
    Movie.should respond_to(:similar_to)
  end

  it "has ratings" do
    Movie.all_ratings == %w(G PG PG-13 NC-17 R)
  end

  context "when a movie is passed as argument" do
    let(:movie) { Movie.create(director: 'toto') }

    before(:each) do
      3.times { Movie.create(director: 'toto') }
      3.times { Movie.create(director: 'non toto') }
    end

    it "returns a list of movies with the same director" do
      Movie.similar_to(movie).should have(4).items
    end
  end
end

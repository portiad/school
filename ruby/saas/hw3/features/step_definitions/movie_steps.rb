# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  Movie.create(movies_table.hashes)
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  page.body.should match(/#{e1}.*#{e2}/m)
end

Then /I should see no movie/ do
  Movie.find_each do |movie|
    page.should_not have_content(movie.title)
  end
end

Then /I should see all of the movies/ do
  Movie.find_each do |movie|
    page.should have_content(movie.title)
  end
end

Then /I should see movies with the following ratings: (.*)/ do |rating_list|
  ratings = rating_list.split(/\s*,\s*/)
  Movie.where(rating: ratings).find_each do |movie|
    page.should have_content(movie.title)
  end
end

Then /I should not see movies with the following ratings: (.*)/ do |rating_list|
  ratings = rating_list.split(/\s*,\s*/)
  Movie.where(rating: ratings).find_each do |movie|
    page.should_not have_content(movie.title)
  end
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I ((?:un)?check) the following ratings: (.*)/ do |check, rating_list|
  rating_list.split(/\s*,\s*/).each do |rating|
    step %Q{I #{check} "ratings_#{rating}"}
  end
end

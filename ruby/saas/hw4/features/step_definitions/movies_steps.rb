Given /^the following movies exist:$/ do |table|
  Movie.create(table.hashes)
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |movie, director|
  Movie.where(title: movie).first.director.should == director
end

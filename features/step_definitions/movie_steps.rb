# Add a declarative step here for populating the DB with movies.

Given /^the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
  assert movies_table.hashes.size == Movie.all.count
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
    titles = page.all("table#movies tbody tr td[1]").map {|t| t.text}
    assert titles.index(e1) < titles.index(e2)
end

Then /^I should totally see/ do

end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

Given /^all checkboxes are (un)?checked: (.*)/ do |unchecked, checkboxes|
  checkboxes.split(/, /).each do |value|
    if(unchecked.to_s.include?("un"))
      uncheck("ratings_#{value}")
    else
      uncheck("ratings_#{value}")
    end
  end
end

Then /^I should( not)? see the movies: (.*)/ do |neg, checkboxes|
  checkboxes.split(/, /).each do |value|
    "Then I should#{neg} see '#{value}'"
  end
end

Given /^all ratings are (un)?checked/ do |unchecked|
  Movie.all_ratings.each do |rating|
    if(unchecked.to_s.include?("un"))
      uncheck("ratings_#{rating}")
    else
      check("ratings_#{rating}")
    end
  end
end

Then /^I should( not)? see all of the movies/ do |negpos|
  if(negpos.to_s.include?("not"))
    page.all("table#movies tbody tr").count.should == 0
  else
    page.all("table#movies tbody tr").count.should == Movie.all.count
  end
end

Given /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(/, /).each do |value|
    if(uncheck.to_s.include?("un"))
      uncheck("ratings_#{value}")
    else
      check("ratings_#{value}")
    end
  end
end

Given /I really uncheck the following ratings: (.*)/ do |rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(/, /).each do |value|
    uncheck("ratings_#{value}")
  end
end
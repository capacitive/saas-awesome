# Add a declarative step here for populating the DB with movies.

Given /^the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
  assert movies_table.hashes .size == Movie.all.count
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
    titles = page.all("table#movies tbody tr td[1]").map {|t| t.text}
    assert titles.index(e1) < titles.index(e2)
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

Given /^all checkboxes are unchecked: (.*)/ do |checkboxes|
  checkboxes.split(/, /).each do |value|
    uncheck("ratings_#{value}")
    #"I uncheck" "ratings_#{value}"
  end
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(/, /).each do |value|
    if(uncheck.to_s.include?("un"))
      uncheck("ratings_#{value}")
    else
      check("ratings_#{value}")
    end
       #"When I #{uncheck}" "ratings_#{value}"
  end
end

When(/^I enter "(.*?)" into search field$/) do |search_word|

end

And (/^search suggestions should be displayed$/) do

end

Then /^search suggestions should not be displayed$/ do

end

And /^I should see at least 5 suggestions$/ do |number_of_suggestions|

end

And /^all suggestions should contain search word "(.*?)"$/ do |search_word|

end

And /^the last suggestion should be equal to "(.*?)"$/ do |search_word|
end


And  /^first suggestions should contain complete word "(.*?)"$/ do |search_word|
end

And /^all suggestions should contain part of "(.*?)"$/ do |search_word|
end

And /^in auto completion correct value "(.*?)" is displayed$/ do |corrected_word|

end
And /^in auto completion correct values "(.*?)" and "(.*?)" are displayed$/ do |first_part,second_part|

end


When (/^I search for "(.*?)"$/) do |word|
  @search_word = word
  search_blinkbox_books @search_word

end

Then /^search results should be displayed$/ do
  assert_search_results @search_word
end

Then /^the author name of first book displayed should contain "(.*?)"$/ do |author_name|

end

Then /^the title of first book displayed should contain "(.*?)"$/ do |book_title|

end

Then /^only one matching search result should be displayed$/ do

end

Then /^book name should be "(.*?)"$/ do |author_name|

end

Then /^author name should be "(.*?)"$/ do |book_title|

end
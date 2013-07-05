And(/^I search for term "(.*?)"$/) do |term|
  fill_in('term', :with => "#{term}")
  click_button('submit_desk')
end

Then(/^I should have a result page with term "(.*?)" matching$/) do |term|
  find('[data-test="search-results-list"]').should have_content("#{term}".titleize)
end

And(/^the result is displayed in Grid mode$/) do
  find('[data-test="list-button"]').visible?.should == true
end

And(/^I should see the sort option drop down$/) do
  find('div.orderby').find('div.item').find('a.ng-binding').visible?.should == true
end

Given(/^I change from Grid mode to List mode$/) do
  find('[data-test="list-button"]').click
end

And(/^the result should be displayed in Grid mode$/) do
  find('[data-test="grid-button"]').visible?.should == true
end

And(/^the result should be displayed in List mode$/) do
  find('[data-test="list-button"]').visible?.should == true
end

When(/^I change from List mode to Grid mode$/) do
  page.find('[ata-test="grid-button"]').click
end

And(/^I take the number books on Grid mode$/) do
  @grid_mode_li = find('[data-test="search-results-list"]').all('li').length
end

And(/^I take the number books on List mode$/) do
  @list_mode_li = find('[data-test="search-results-list"]').all('li').length
end

And(/^the number of books should match on both mode$/) do
  @grid_mode_li.should == @list_mode_li
end

And(/^the Tesco clubcard logo should be visible$/) do
  all('[data-test="book-clubcard-points"]').first.visible?.should == true
end

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
  assert_author_name author_name

end

Then /^the title of first book displayed should contain "(.*?)"$/ do |book_title|
   assert_title book_title
end

Then /^only one matching search result should be displayed$/ do
  assert_search_results @search_word
  assert_unique_result
end

Then /^book name should be "(.*?)"$/ do |book_title|
     assert_title book_title
end

Then /^author name should be "(.*?)"$/ do |author_name|
      assert_author_name author_name
end

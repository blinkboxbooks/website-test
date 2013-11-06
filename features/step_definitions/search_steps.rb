And(/^I search for term "(.*?)"$/) do |term|
  @search = term
  search_blinkbox_books @search
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
  page.find('[data-test="grid-button"]').click
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

Then(/^I should get a message$/) do
  page.should have_content(@search)
  page.should have_content(find('h5.ng-binding').text)
end

And(/^the options of switching view mode should not appear$/) do
  page.should_not have_css('div#controls')
end

And(/^(\d+) Bestselling books should be returned$/) do |n|
  find('[data-test="search-results-list"]').all('li').length.should == n.to_i
end

When(/^I type "(.*?)" into search field$/) do |search_word|
  fill_in('term', :with => "#{search_word}")
end

And (/^search suggestions should be displayed$/) do
  (find("#suggestions")[:class]).should == 'enabled'
end

Then /^search suggestions should not be displayed$/ do
  page.should_not have_css("#suggestions")

end

And /^I should see at least (\d+) suggestions$/ do |number_of_suggestions|
  assert_number_of_suggestions  number_of_suggestions.to_i
end

And /^all suggestions should contain search word "(.*?)"$/ do |search_word|
  assert_search_word_in_suggestions search_word
end

And /^the last suggestion should be equal to "(.*?)"$/ do |search_word|
  assert_last_suggestion search_word
end


And  /^first suggestions should contain complete word "(.*?)"$/ do |search_word|
  pending
end

And /^all suggestions should contain part of "(.*?)"$/ do |search_word|
  pending
end

And /^in auto completion correct value "(.*?)" is displayed$/ do |corrected_word|
 assert_auto_corrected_word [corrected_word]
end
And /^in auto completion correct values "(.*?)" and "(.*?)" are displayed$/ do |first_part,second_part|
  assert_auto_corrected_word [first_part, second_part ]
end


When (/^I search for "(.*?)"$/) do |word|
  @search_word = word
  search_blinkbox_books @search_word
end

And(/^at least 1 search result is shown$/) do
  search_results_page.should have_results
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

Then /^"(.*?)" should be visible in search bar$/ do |search_word|
  find('[data-test="header-container"]').find('[data-test="search-input"]')[:value].should == search_word
end

Then /^search term should not be visible in search bar$/ do
  find('[data-test="header-container"]').find('[data-test="search-input"]')[:value].should == ""
end

When /^I change search term in url to "(.*?)"$/ do |edit_word|
  @search_word = edit_word
  visit("/#!/search/?q=#{edit_word}")
  puts @search_word
end

And /^page url should have "(.*?)"$/ do |search_word|
  (current_url.include?(search_word)).should == true
  @current_url = current_url.to_s
end

And /^copy paste url into another browser session$/ do
  session = Capybara::Session.new(:selenium)
  session.visit(@current_url)
end

When /^I search for following words$/ do |table|
   table.hashes.each do |search_word|
     search_blinkbox_books search_word['words']
   end
end
And /^I should see search results page for "(.*?)"$/ do |search_word|
  assert_search_results search_word
end


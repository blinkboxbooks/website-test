And(/^I search for term "(.*?)"$/) do |term|
  @search = term
  search_blinkbox_books @search
end

Then(/^I should have a result page with term "(.*?)" matching$/) do |term|
  find('[data-test="search-results-list"]').should have_content("#{term}".titleize)
end

And(/^the result (?:is displayed in|should be displayed in) (Grid|List) mode$/) do |expected_view|
  expect(search_results_page.current_view).to be == expected_view.to_sym
end

And(/^I should see the sort option drop down$/) do
  find('div.orderby').find('div.item').find('a.ng-binding').visible?.should == true
end

Given(/^I change from Grid mode to List mode$/) do
  switch_to_list_view
end

And(/^the result should be displayed in Grid mode$/) do
  expect(search_results_page.current_view).to eq(:grid)
end

When(/^I change from List mode to Grid mode$/) do
  switch_to_grid_view
end

And(/^I take the number books on Grid mode$/) do
  @grid_mode_books = books_section.books.count
end

And(/^I take the number books on List mode$/) do
  @list_mode_books = books_section.books.count
end

And(/^the number of books should match on both mode$/) do
  expect(@grid_mode_books).to be == @list_mode_books
end

And(/^the Tesco clubcard logo should be visible$/) do
  expect(search_results_page.book_results_sections.first.books.first).to have_clubcard_points
  expect(search_results_page.book_results_sections.first.books.first).to have_clubcard_logo
end

Then(/^I should get a message$/) do
  page.should have_content(@search)
  page.should have_selector("#noResults")
end

And(/^the options of switching view mode should not appear$/) do
  expect(search_results_page).to_not have_list_view_button
  expect(search_results_page).to_not have_grid_view_button
end

When(/^I type "(.*?)" into search field$/) do |search_word|
  current_page.search_form.keyword.set search_word
end

And /^search suggestions should be displayed$/ do
  current_page.search_form.wait_for_suggestions
  current_page.search_form.wait_until_suggestions_visible
  current_page.search_form.should have_suggestions
end

Then /^search suggestions should not be displayed$/ do
  current_page.search_form.should have_no_suggestions
end

And /^I should see at least (\d+) suggestions$/ do |number_of_suggestions|
  assert_number_of_suggestions  number_of_suggestions.to_i
end

And /^all suggestions should contain search word "(.*?)"$/ do |search_word|
  assert_search_word_in_suggestions search_word
end

And /^all suggestions should contain part of "(.*?)"$/ do |search_word|
  current_page.search_form.suggestions.each { |suggestion| suggestion.text.should include(search_word) }
end

And /^first suggestions should contain complete word "(.+)"$/ do |search_word|
  current_page.search_form.suggestions[0].text.should include(search_word)
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
  expect(search_results_page.book_results_sections.first).to have_books
  expect(search_results_page.book_results_sections.first.books.count).to be > 0
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
  within('#searchbox') do
    find('#term')[:value].should eql(search_word)
  end

end

Then /^search term should not be visible in search bar$/ do
  within('#searchbox') do
    find('#term')[:value].should eql("")
  end
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


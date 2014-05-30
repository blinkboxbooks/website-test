And(/^I search for term "(.*?)"$/) do |term|
  @search = term
  search_blinkbox_books @search
end

Then(/^I should have a result page with term "(.*?)" matching$/) do |term|
  expect(find('[data-test="search-results-list"]')).to have_content("#{term}".titleize)
end

And(/^the result is displayed in Grid mode$/) do
  expect(find('[data-test="list-button"]')).to be_visible
end

And(/^I should see the sort option drop down$/) do
  expect(find('div.orderby').find('div.item').find('a.ng-binding')).to be_visible
end

Given(/^I change from Grid mode to List mode$/) do
  find('[data-test="list-button"]').click
end

And(/^the result should be displayed in Grid mode$/) do
  expect(find('[data-test="grid-button"]')).to be_visible
end

And(/^the result should be displayed in List mode$/) do
  expect(find('[data-test="list-button"]')).to be_visible
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
  expect(@grid_mode_li).to eq(@list_mode_li)
end

And(/^the Tesco clubcard logo should be visible$/) do
  expect(all('[data-test="book-clubcard-points"]').first).to be_visible
end

Then(/^I should get a message$/) do
  expect(page).to have_content(@search)
  expect(page).to have_selector("#noResults")
end

And(/^the options of switching view mode should not appear$/) do
  expect(page).to have_css('div#controls')
end

And(/^(\d+) Bestselling books should be returned$/) do |n|
  expect(find('[data-test="search-results-list"]').all('li').length).to eq(n.to_i)
end

When(/^I type "(.*?)" into search field$/) do |search_word|
  current_page.search_form.fill_in 'term', :with => search_word
end

And /^search suggestions should be displayed$/ do
  current_page.search_form.wait_for_suggestions
  current_page.search_form.wait_until_suggestions_visible
  expect(current_page.search_form).to have_suggestions
end

Then /^search suggestions should not be displayed$/ do
  expect(current_page.search_form).to have_no_suggestions
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

And /^all suggestions should contain part of "(.*?)"$/ do |search_word|
  current_page.search_form.suggestions.each { |suggestion| expect(suggestion.text).to include(search_word) }
end

And /^first suggestions should contain complete word "(.+)"$/ do |search_word|
  expect(current_page.search_form.suggestions[0].text).to include(search_word)
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
  page.has_selector?("div.itemsets")
  search_results_page.has_books?
  expect(search_results_page).to have_books
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
    expect(find('#term')[:value]).to eq(search_word)
  end
end

Then /^search term should not be visible in search bar$/ do
  within('#searchbox') do
    expect(find('#term')[:value]).to eq("")
  end
end

When /^I change search term in url to "(.*?)"$/ do |edit_word|
  @search_word = edit_word
  visit("/#!/search/?q=#{edit_word}")
  puts @search_word
end

And /^page url should have "(.*?)"$/ do |search_word|
  expect(current_url).to include(search_word)
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


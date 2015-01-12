When(/^I click on next button on pagination$/) do
  search_results_page.pagination.click_on_next_button
end

When(/^I click on previous button on pagination$/) do
  search_results_page.pagination.click_on_previous_button
end

When(/^I click on page number "(\d+)"$/) do |page_number|
  search_results_page.pagination.click_on_pagination_number(page_number)
end

Then(/^page number url should have "(\d+)"$/) do |page_number|
  expect(current_url).to include(page_number)
end

Then(/^pagination should be displayed in (?:grid|list)?/) do
  expect(search_results_page.pagination).to have_pagination_numbers
end

Then(/^pagination is displayed$/) do
  (search_results_page.pagination).wait_until_pagination_numbers_visible
  expect(search_results_page.pagination).to have_pagination_numbers
end

Then(/^then the selected page number should be "(\d+)"$/) do |page_number|
  expect(search_results_page.pagination.selected_page_number.text(page_number)).to eq(page_number)
end

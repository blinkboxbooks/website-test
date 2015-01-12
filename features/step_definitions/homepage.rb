Then(/^main footer is displayed$/) do
  expect(current_page).to have_footer
end

Then(/^main header is displayed$/) do
  expect(current_page).to have_header
end

When(/^number of banners is between (\d+) and (\d+)$/) do |min_banners, max_banners|
  @min_banners = min_banners.to_i
  @max_banners = max_banners.to_i
end

Then(/^homepage hero banner is displayed$/) do
  assert_homepage_banner_displayed
end

And(/^banner has background images$/) do
  assert_homepage_banner_images(@min_banners, @max_banners)
end

And(/^homepage hero banner has navigation buttons$/) do
  assert_homepage_banner_navigation(@min_banners, @max_banners)
end

Then(/^each banner image has title and subtitle$/) do
  pending
end

And(/^each banner image has Find out more button$/) do
  pending
end

Then(/^(.*?) promotable category has (\d+) books$/) do |category_name, no_of_books|
  assert_promotable_category(category_name, no_of_books)
end

And(/^all the books displayed$/) do
  assert_all_books_displayed
end

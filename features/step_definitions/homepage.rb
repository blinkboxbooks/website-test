Then /^main footer is displayed$/ do
  current_page.should have_footer
end

Then /^main footer has "(.*?)" displayed$/ do |section|
   assert_footer_section(section)
end

When /^number of banners is between (\d+) and (\d+)$/ do |min_banners, max_banners|
 @min_banners = min_banners.to_i
 @max_banners = max_banners.to_i
end

Then /^homepage hero banner is displayed$/ do
  expect(home_page.banner).to be_visible
end

And /^banner has background images$/ do
  expect(home_page.banner.slides.count).to be_between(@min_banners, @max_banners)
  home_page.banner.images.each { |image| expect(image).to be_visible }
end

And /^homepage hero banner has navigation buttons$/ do
  expect(home_page.banner.slide_numbers.count).to be_between(@min_banners, @max_banners)
end

And /^main footer has (\d+) columns with links$/ do |arg1|
  pending
end

Then /^each banner image has title and subtitle$/ do
  pending
end

And /^each banner image has Find out more button$/ do
 pending
end

Then /^(.*?) promotable category has (\d+) books$/ do |category_name, no_of_books|
  if category_name.include?('Spotlight')
    @category = home_page.spotlight_on_category
  else
    @category = home_page.highlights_category
  end

  expect(@category.books).to have(no_of_books.to_i).items
end

And /^all the books displayed$/ do
  expect(@category.invisible_books).to have(0).items
end



When /^I am viewing in (.*?) mode$/ do |viewing_mode|
  set_viewing_mode(viewing_mode)
end

And /^page should display (\d+) categories in a row$/ do |expected_top_categories|
  assert_number_of_categories(expected_top_categories)
end

When /^(\d+) is valid|invalid category id$/ do |category_id|
  @category_id = category_id
end

Then /^page should display the category$/ do
  assert_category_displayed(@category_id)
end

And /^category name should be "(.*?)"$/ do |category_name|
  assert_category_title(@category_id, category_name)
end

And /^page should display category image$/ do
  assert_category_image_displayed(@category_id)
end

Then /^page should not display the category$/ do
  assert_category_not_displayed(@category_id)
end

And /^page should display categories as list$/ do
  assert_categories_list
end

And /^I select (list|grid) view$/ do |view|
  switch_to_view(view)
end

Then /^long titles should be displayed in two lines$/ do
  pending
end

Then /^long titles should be truncated to fit within image$/ do
  pending
end

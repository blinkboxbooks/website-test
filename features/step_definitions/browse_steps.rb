When /^I am viewing in (.*?) mode$/ do |viewing_mode|
  case viewing_mode
    when 'Desktop'
      maximize_window
    when 'Mobile Portrait'
      resize_window(320, 480)
    when 'Mobile Landscape'
      resize_window(480, 320)
    when '10 inch tablet'
      resize_window(800, 1024)
    when '7 inch tablet'
      resize_window(550, 1024)
    else
      raise "Unsupported browser viewing mode: #{viewing_mode}"
  end
end

And /^page should display (\d+) categories in a row$/ do |expected_top_categories|
  expect(categories_page.top_categories).to have_exactly(expected_top_categories.to_i).items
end

When /^(\d+) is valid|invalid category id$/ do |category_id|
  @category_id = category_id
end

Then /^page should display the category$/ do
  expect(categories_page).to have_category(@category_id)
end

And /^category name should be "(.*?)"$/ do |category_name|
  expect(categories_page.category_by_id(@category_id).title).to eq(category_name)
end

And /^page should display category image$/ do
  category = categories_page.category_by_id(@category_id)
  expect(category.cover_image).to be_visible
end

Then /^page should not display the category$/ do
  expect(categories_page).to_not have_category(@category_id)
end

And /^page should display categories as list$/ do
  expect(categories_page).to have_top_categories
  categories_page.top_categories.each { |category_box| expect(category_box).to have_no_cover_image }
end

And /^I select (list|grid) view$/ do |view|
  case view
    when 'list'
      if !((find('.list-view')[:class]).include?('active'))
       page.find('.list-view').click
      end
    when 'grid'
      if !((find('.grid-view')[:class]).include?('active'))
       page.find('.grid-view').click

     end
  end
end

Then /^long titles should be displayed in two lines$/ do

end

Then /^long titles should be truncated to fit within image$/ do

end

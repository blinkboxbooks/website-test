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
  top_categories = categories_page.top_categories

  expect(top_categories.count).to be == expected_top_categories.to_i
  index = 0
  top_categories.each do |category_box|
    index += 1
    if index <= expected_top_categories.to_i
      expect(category_box.displayed?).to be true
    else
      expect(category_box.displayed?).to be false
    end
  end
end

When /^(\d+) is valid|invalid category id$/ do |category_id|
  @category_id = category_id
end

Then /^page should display the category$/ do
  expect(is_category_displayed(@category_id)).to be true
end

And /^category name should be "(.*?)"$/ do |category_name|
  category = categories_page.category_by_id(@category_id)
  expect(category.title).to be == category_name
end

And /^page should display category image$/ do
  category = categories_page.category_by_id(@category_id)
  expect(category.cover_image).to be_visible
end

Then /^page should not display the category$/ do
  expect(is_category_displayed(@category_id)).to be false
end

And /^page should display categories as list$/ do
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

When /^I am viewing in (.*?) mode$/ do |viewing_mode|
  case viewing_mode
    when 'Desktop'
      maximize_window
    when 'Mobile Portrait'
      resize_window(320,480)
    when 'Mobile Landscape'
      resize_window(480,320)
    when '10 inch tablet'
      resize_window(800,1024)
    when '7 inch tablet'
      resize_window(550,1024)
    else
      raise "Unsupported browser viewing mode: #{viewing_mode}"
  end
end

And /^page should display (\d+) categories in a row$/ do |top_categories|
  #TODO Explore how to make this step less brittle
  within('[data-test="recommended-category-container"]') do
    expect(page.all('li',:visible => false).count).to eq(top_categories.to_i)
    expect(evaluate_script("document.getElementsByClassName('list_categories')[0].children[4].offsetLeft")).to eq(772)
    expect(evaluate_script("document.getElementsByClassName('list_categories')[0].children[4].offsetTop")).to eq(54)
  end
end

When /^(\d+) is valid|invalid category id$/ do |category_id|
  @category_id = category_id
end

Then /^page should display the category$/ do
  expect(is_category_displayed(@category_id)).to be true
end

And /^category name should be "(.*?)"$/ do |category_name|
  category = find_category @category_id
  expect(find("[data-test=\"#{category}\"]").text).to eq(category_name)
end

And /^page should display category image$/ do
  category = find_category @category_id
  find("[data-test=\"#{category}\"]").visible?
   within("[data-test=\"#{category}\"]") do
     expect(find('img')['ng-src']).to include('http://')
   end
end

Then /^page should not display the category$/ do
  expect(is_category_displayed(@category_id)).to be false
end

And /^page should display categories as list$/ do
  within('[data-test="recommended-category-list"]') do
    categories = page.all('li').to_a
    expect(categories.all?{ |category| category.find('[data-category="category"]').has_css?('div.cover', :count => 0) == true }).to be true, "Some categories were not being displayed as lists: #{categories}"
  end
end


And /^page should display (\d+) categories per a row$/ do |top_categories|
  #TODO remove this duplicate step
  expect(evaluate_script("document.getElementsByClassName('list_categories')[0].children[4].offsetLeft")).to eq(20)
  expect(evaluate_script("document.getElementsByClassName('list_categories')[0].children[4].offsetTop")).to eq(376)
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

When /^I am viewing in Desktop mode$/ do
  @window = Capybara.current_session.driver.browser.manage.window
  @window.maximize
end

When /^I am viewing in (\d+) inch tablet mode$/ do |tablet_size|
  case tablet_size
    when "10"
      page.driver.browser.manage.window.resize_to(768,1024)
     # @window.resize_to(1024, 768)
    when "7"
      @window.resize_to(1024, 768)
  end

end

And /^page should display (\d+) categories in a row$/ do |top_categories|
  within('[data-test="recommended-category-container"]') do
   (page.all('li',:visible => false).count).should == top_categories.to_i
  end
end

When /^(\d+) is valid|invalid category id$/ do |category_id|
  @category_id = category_id
  puts @category_id
end

Then /^page should display the category$/ do
  is_category_displayed(@category_id).should==true
end

And /^category name should be "(.*?)"$/ do |category_name|
  category = find_category @category_id
  find("[data-test=\"#{category}\"]").text.eql?(category_name).should == true
end

And /^page should display category image$/ do
  category = find_category @category_id
   within("[data-test=\"#{category}\"]")do
     (find('div.cover').find('a').find('img')['ng-src']).include?("http://").should == true
   end
end

Then /^page should not display the category$/ do
  is_category_displayed(@category_id).should==false
end


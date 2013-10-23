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
   (page.all('li',:visible => false).count).should == top_categories.to_i
   page.evaluate_script("document.getElementsByClassName('list_categories')[0].children[4].offsetLeft").should == 772
   page.evaluate_script("document.getElementsByClassName('list_categories')[0].children[4].offsetTop").should ==54
  end
end

When /^(\d+) is valid|invalid category id$/ do |category_id|
  @category_id = category_id
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
  find("[data-test=\"#{category}\"]").visible?
   within("[data-test=\"#{category}\"]")do
     (find('img')['ng-src']).include?("http://").should == true
   end
end

Then /^page should not display the category$/ do
  is_category_displayed(@category_id).should==false
end

And /^page should display categories as list$/ do
  within('[data-test="recommended-category-list"]')do
    page.all('li').to_a.each do |li|
      within li.find('[data-category="category"]')do
        page.should have_css('div.cover',:count => 0)
       end
    end
  end
end


And /^page should display (\d+) categories per a row$/ do |top_categories|
  #TODO remove this duplicate step
   page.evaluate_script("document.getElementsByClassName('list_categories')[0].children[4].offsetLeft").should == 20
   page.evaluate_script("document.getElementsByClassName('list_categories')[0].children[4].offsetTop").should == 376

end

And /^I select (list|grid) view$/ do |view|
  case view
    when 'list'
      if find('[data-test="grid-button"]')[:class] =='active'
       page.find('[data-test="list-button"]').click
      end
    when 'grid'
      if find('[data-test="list-button"]')[:class] == 'active'
       page.find('[ata-test="grid-button"]').click

     end
  end
end

Then /^long titles should be displayed in two lines$/ do

end

Then /^long titles should be truncated to fit within image$/ do

end

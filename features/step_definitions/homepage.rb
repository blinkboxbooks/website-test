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
  (find('[id="slider"]').visible?).should == true
end

And /^banner has background images$/ do
  within('[id="slider"]') do
     (page.all('li',:visible => false).count).should be_between(@min_banners,@max_banners)
     page.all('li').to_a.each do |li|
       (li.find('img').visible?).should == true
    end
  end
end

And /^homepage hero banner has navigation buttons$/ do
  within('[id="active"]') do
   (page.all('label').count).should be_between(@min_banners,@max_banners)
  end
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
    home_page.should be_all_there
    selector = home_page.highlights
    if category_name.include?('eBooks')
      selector = home_page.ebooks_on_film
    end
      within(selector) do
        @visible_books = page.all('li', :visible => true).count
        @all_books = page.all('li', :visible => false).count
        @all_books.should eql(no_of_books.to_i)
      end
end

And /^all the books displayed$/ do
  @all_books.should eql(@visible_books)
end



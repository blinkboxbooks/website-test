Given /^I am on the home page/ do 
	visit('/')
  page.driver.browser.manage.window.maximize
end

##############################################################
# testing header
##############################################################

When /^I click on the website logo$/ do
	find('[data-test="logo-link"]').click
end

Then /^I should return to the home page$/ do
	current_path.should == '/'
end

##############################################################
# testing main navigation
##############################################################

Then /^I should be on the (.*?) page$/ do |page_name|
	#current_url.should == Capybara.app_host << '/#!/categories/'
  case page_name
    when "Categories"
      current_url.include?('/#!/categories/').should == true
    when "Best sellers"
      current_url.include?('#!/bestsellers/').should == true
  end

end 

##############################################################
# testing footer links
##############################################################

Given /^the blinkbox books help link is present in the footer$/ do 
	@help_link = find('[data-test="bottom-footer-container"]').find('[data-test="footer-help-link"]')
	@help_link.visible?.should == true
end 

Then /^the link should point to the blinkbox books help home page$/ do 
	@help_link[:href].should == 'https://blinkboxbooks.zendesk.com/'
  @help_link[:target].should == '_blank'
  @help_link[:title].should == 'Help'
end 

Given /^the blinkbox movies link is present in the footer$/ do 
	@movies_link = find('[data-test="bottom-footer-container"]').find('[data-test="footer-movies-link"]')
	@movies_link.visible?
end 

Then /^the link should point to the blinkbox movies home page$/ do 
	@movies_link[:href].should == 'http://www.blinkbox.com/'
	@movies_link[:target].should == '_blank'
	@movies_link[:title].should == 'Blinkbox movies'
end 

Given /^the blinkbox music link is present in the footer$/ do 
	@music_link = find('[data-test="bottom-footer-container"]').find('[data-test="footer-music-link"]')
	@music_link.visible?
end 

Then /^the link should point to the blinkbox music home page$/ do 
	@music_link[:href].should == 'http://www.blinkboxmusic.com/'
	@music_link[:target].should == '_blank'
	@music_link[:title].should == 'Blinkbox music'
end

And /^I click on the (.*) link$/ do |page|

  case page
    when "Featured"
      find('[data-test="header-container"]').find('[data-test="header-featured"]').click
    when "Categories"
      find('[data-test="header-container"]').find('[data-test="header-categories-link"]').click
    when "Best sellers"
      find('[data-test="header-container"]').find('[data-test="header-bestsellers-link"]').click
    when "New releases"
      find('[data-test="header-container"]').find('[data-test="header-new-releases-link"]').click
    when "Top free"
      find('[data-test="header-container"]').find('[data-test="header-top-free-link"]').click
    when "Authors"
      find('[data-test="header-container"]').find('[data-test="header-authors-link"]').click

  end
end

And /^I press browser back$/ do
  page.evaluate_script('window.history.back()')
end

And /^main header tabs should not be selected$/ do
  within("#nav_menu") do
    page.all('li').to_a.each do |li|
      ((li[:class]).include?("current")).should == false
    end
  end

end

And /^footer is displayed$/ do
  find('[data-test="bottom-footer-container"]').visible?
end

When /^a promotable category has more books to display$/ do
  within("#books_news") do
    @visible_books =  page.all('li',:visible => true).count
    @all_books = page.all('li', :visible => false).count
    (@all_books > @visible_books).should == true
  end

end

And /^I click on View (.*) button$/ do |arg1|
  within("#books_news") do
    unless (@all_books > @visible_books) == false
      find('[data-test="expand-list-button"]').click
    end
  end
end

Then /^I should see more books displayed$/ do
 within('#books_news') do
   (page.all('li', :visible => true).count).should ==(2*@visible_books)
 end
end

And /^I click on view more button until all the books are displayed$/ do
  within('#books_news') do
    until  @all_books == page.all('li',:visible => true).count
      find('[data-test="expand-list-button"]').click
    end
  end
end

Then /^the button should change to View less$/ do
  within('#books_news') do
    ((find('[data-test="expand-list-button"]'))[:title]).should =="View less"
  end
end

Then /^the button should change to View more$/ do
  within('#books_news') do
    ((find('[data-test="expand-list-button"]'))[:title]).should =="View more"
  end
end


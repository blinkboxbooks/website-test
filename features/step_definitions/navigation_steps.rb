Given /^I am on the home page/ do 
	visit('/')
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

Then /^I should be on the categories page$/ do 
	current_url.should == Capybara.app_host << '/#!/categories/'
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
    when "Best Sellers"
      find('[data-test="header-container"]').find('[data-test="header-bestsellers-link"]').click
    when "New Releases"
      find('[data-test="header-container"]').find('[data-test="header-new-releases-link"]').click
    when "Top Free"
      find('[data-test="header-container"]').find('[data-test="header-top-free-link"]').click
    when "Authors"
      find('[data-test="header-container"]').find('[data-test="header-authors-link"]').click

  end
end

And /^I press browser back$/ do
  page.evaluate_script('window.history.back()')
end




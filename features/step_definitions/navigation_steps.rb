Given /^I am on the home page/ do 
	visit('/')
end

When /^I click on the website logo$/ do
	find('[data-test="logo-link"]').click
end

Then /^I should return to the home page$/ do
	current_path.should == '/'
end

Given /^the blinkbox books help link is present in the footer$/ do 
	link = find('[data-test="bottom-footer-container"]').find('[data-test="footer-movies-link"]').visible?
end 

Then /^the link should point to the blinkbox books help home page$/ do 
	link = find('[data-test="bottom-footer-container"]').find('[data-test="footer-help-link"]')
	link[:href].should == 'https://blinkboxbooks.zendesk.com/'
	link[:target].should == '_blank'
	link[:title].should == 'Help'
end 


#Given /^the categories link is present in the header$/ do 
#	link = find('[data-test="header-container"]').find('[data-test="header-categories-link"]').visible?
#end 

#Then /^the link should point to the categories page$/ do 
#	link = find('[data-test="header-container"]').find('[data-test="header-categories-link"]')
#	link[:href].should == Capybara.app_host << '/#!/categories/'
#	link[:title].should == 'Categories'
#end 

When /^I click on the categories link$/ do 
	find('[data-test="header-container"]').find('[data-test="header-categories-link"]').click
#	find('[data-test="header-categories-link"]').click
end  

Then /^I should be on the categories page$/ do 
	current_url.should == Capybara.app_host << '/#!/categories/'
end 



Given /^the blinkbox movies link is present in the footer$/ do 
	link = find('[data-test="bottom-footer-container"]').find('[data-test="footer-movies-link"]').visible?
end 

Then /^the link should point to the blinkbox movies home page$/ do 
	link = find('[data-test="bottom-footer-container"]').find('[data-test="footer-movies-link"]')
	link[:href].should == 'http://www.blinkbox.com/'
	link[:target].should == '_blank'
	link[:title].should == 'Blinkbox movies'
end 

Given /^the blinkbox music link is present in the footer$/ do 
	link = find('[data-test="bottom-footer-container"]').find('[data-test="footer-music-link"]').visible?
end 

Then /^the link should point to the blinkbox music home page$/ do 
	link = find('[data-test="bottom-footer-container"]').find('[data-test="footer-music-link"]')
	link[:href].should == 'http://www.blinkboxmusic.com/'
	link[:target].should == '_blank'
	link[:title].should == 'Blinkbox music'
end 

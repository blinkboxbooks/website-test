Given /I am on the home page/ do 
	visit('/')
end

When /I click on the website logo/ do
	find('[data-test="logo-link"]').click
end

Then /I should return to the home page/ do
	current_path.should == '/'
end


When /I click on the help link in the footer/ do 
	find('[data-test="footer-help-link"]').click
end

Then /I should see the blinkbox help page/ do 
	page.driver.browser.switch_to.window(page.driver.browser.window_handles.last)
	current_url.should == 'https://blinkboxbooks.zendesk.com/home'
end



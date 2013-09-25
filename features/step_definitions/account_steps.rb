Given /^I am a guest user$/ do
   delete_cookies
end

Given /^I am not signed in$/ do
    delete_cookies
end

Given /^I am on the Sign in page$/  do
  visit('/#!/signin')
end

When /^I click register button$/  do
   find('[class="blue_button ng-binding"]').click
end

Then /^Register page is displayed$/  do
  current_url.include?('#!/register').should == true
end

Given /^I am on Register page$/ do
  visit('/#!/register')
end

When /^I enter valid personal details$/ do
   enter_personal_details
end

And /^I choose a valid password$/ do
  password='test1234'
  choose_a_valid_password(password)
end

And /^I accept terms and conditions$/ do
  check('termsconditions')
end

Then /^Registration success page is displayed$/ do
  page.find('.welcome').should have_content("Welcome book lover")
  current_url.include?('#!/success').should == true
end

And /^I submit registration details$/  do
  find('[class="yellow_button ng-binding"]').click
end

When /^I enter valid sign in details$/ do
  email = 'happay_path_signin@blinkboxbooks.com'
  password = "test1234"
  @first_name = "Happy-path"
  enter_valid_sign_in_details(email,password)
end

And /^I click sign in button$/ do
  find('[class="yellow_button float-right ng-binding"]').click
end

Then /^I am successfully signed in$/  do
  find('[id="username"]').text.should == "Hi "+@first_name
end

And /^I am redirected to Home page$/  do
  current_path.should == '/'
end

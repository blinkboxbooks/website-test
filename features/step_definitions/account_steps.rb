Given /^I am a guest user$/ do
  delete_cookies
end

Given /^I am not signed in$/ do
  delete_access_token_cookie
end

Given /^I have signed in$/ do
  sign_in(@email_address)
end

When /^I sign in(?: to proceed with purchase)?$/ do
  sign_in
end

Given /^I am on the Sign in page$/ do
  visit('/#!/signin')
end

When /^I click register button$/ do
  click_register_button
end

Then /^Register page is displayed$/ do
  current_url.include?('#!/register').should == true
end

Given /^I am on Register page$/ do
  visit('/#!/register')
end

When /^I enter valid personal details$/ do
  enter_personal_details
end

And /^I choose a valid password$/ do
  choose_a_valid_password('test1234')
end

And /^I accept terms and conditions$/ do
  accept_terms_and_conditions
end

Then /^Registration success page is displayed$/ do
  page.find('.welcome').should have_content(get_message_text('Welcome'))
  current_url.include?('#!/success').should == true
end

And /^I submit registration details$/ do
  submit_registration_details
end

When /^I enter valid sign in details$/ do
  email = 'happay_path_signin@blinkboxbooks.com'
  password = "test1234"
  @first_name = "Happy-path"
  enter_valid_sign_in_details(email, password)
end

And /^I click sign in button$/ do
  click_sign_in_button
end

Then /^I am successfully signed in$/ do
  assert_first_name(@first_name)
end

And /^I am redirected to Home page$/ do
  current_path.should == '/'
end

Given /^I am on my account page$/ do
  click_link_from_my_account_dropdown('Your personal details')
end

And /^I click Sign out button$/ do
  click_button('Sign out')
end

Then /^I should be signed out successfully$/ do
  find('[id="signin"]').should be_visible
  Capybara.current_session.driver.browser.manage.cookie_named('access_token').should be nil
end

And /^I have a stored card$/ do
  visit('/')
  click_sign_in_link
  click_register_button
  register_new_user
  buy_first_book
  click_link_from_my_account_dropdown('Sign out')
  delete_cookies
  visit('/')
end

Given /^I have multiple stored cards$/ do
  @email_address = 'cctest1@aa.com'
end

Given /^I register(?: to proceed with purchase)?$/ do
  click_register_button
  register_new_user
end
Given /^I am a guest user$/ do
  log_out_current_session
  set_start_cookie_accepted
end

Given /^I am not signed in$/ do
  delete_access_token_cookie
end

Given /^I have signed in$/ do
  sign_in(@email_address)
end

When /^I sign in(?: to proceed with purchase| to proceed with adding sample)?$/ do
  sign_in
end

Given /^I am on the Sign in page$/ do
  sign_in_page.load
end

When /^I click register button$/ do
  click_register_button
end


Given /^I am on Register page$/ do
  register_page.load
end

When /^I enter valid personal details$/ do
  @email_address, @first_name, @last_name = enter_personal_details
end

And /^I choose a valid password$/ do
  choose_a_valid_password('test1234')
end

And /^I accept terms and conditions$/ do
  accept_terms_and_conditions
end

And /^welcome message is shown$/ do
  registration_success_page.welcome_label.should have_content(get_message_text('Welcome'))
end

And /^I submit registration details$/ do
  submit_registration_details
end

When /^I enter valid sign in details$/ do
  email = 'happay_path_signin@mobcastdev.com'
  password = "test1234"
  @first_name = "Happy-path"
  enter_valid_sign_in_details(email, password)
end

And /^I click sign in button$/ do
  click_sign_in_button
end

Then /^I am successfully signed in$/ do
  assert_user_greeting_message_displayed(@first_name)
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
  assert_user_greeting_message_not_displayed
  assert_cookie_value('access_token', nil)
end

And /^I have a stored card$/ do
  visit('/')
  navigate_to_register_form
  register_new_user
  expect_page_displayed("Registration Success")
  buy_first_book
  log_out_current_session
  set_start_cookie_accepted
end

Given /^I have multiple stored cards$/ do
  @email_address = 'cctest1@aa.com'
end

Given /^I register(?: to proceed with purchase| to proceed with adding sample)?$/ do
  click_register_button
  register_new_user
end
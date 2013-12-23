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

When /^I (?:click|have selected) register (?:button|option)$/ do
  click_register_button
end


Given /^I am on Register page$/ do
  register_page.load
end

When /^I enter valid personal details$/ do
  @email_address, @first_name, @last_name = enter_personal_details
end

And /^I choose a valid password$/ do
  enter_password('test1234')
end

And /^I accept terms and conditions$/ do
  accept_terms_and_conditions(true)
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

And /^I am redirected to (.*?) page$/ do |page_name|
  expect_page_displayed(page_name)
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

Given /^I have default expired stored card$/ do
 set_email_and_password('one_default_expired_card@mobcastdev.com', 'test1234')
end

Given /^I have multiple saved cards with (default|non-default) card expired$/ do |expired_card|
  if (expired_card.include?('non'))
    email_address ='nondefault_expired_card@mobcastdev.com'
  else
    email_address ='default_expired_card@mobcastdev.com'
  end
  set_email_and_password(email_address, 'test1234')
end

When /^I enter personal details with (valid|invalid) clubcard number$/ do |club_card_type|
  club_card = 634004024023421292
  if club_card_type.include?('invalid')
    club_card = '434004024023421292'
  end
  @email_address, @first_name, @last_name = enter_personal_details
  register_page.fill_in_club_card(club_card)
end

And /^I submit registration details by (accepting|not accepting) terms and conditions$/ do |accept_terms|
  if accept_terms.include?('not')
    accept_terms_and_conditions(false)
  else
    accept_terms_and_conditions(true)
  end
  submit_registration_details
end

When /^I enter registration details with already registered email address$/ do
  @email_address, @first_name, @last_name = enter_personal_details('bkm1@aa.com')
  enter_password('test1234')
end

Then /^registration is not successful$/ do
  expect_page_displayed('Register')
end

When /^I enter valid registration details$/ do
  @email_address, @first_name, @last_name = enter_personal_details
  enter_password('test1234')
end

And(/^link to sign in with already registered email address is displayed$/) do
   page.should have_selector('a', :text =>"Sign in with #{@email_address}")
end

And /^type passwords that are less than 6 characters$/ do
  enter_password('test1')
end

And /^type passwords that are not matching$/ do
  register_page.password.set 'test1234'
  register_page.password_repeat.set 'test2345'
end
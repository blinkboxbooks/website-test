Given(/^I am a guest user$/) do
  log_out_current_session if logged_in_session?
end

Given(/^I am not signed in$/) do
  delete_access_token_cookie
end

Given(/^I (?:am|have) signed in$/) do
  sign_in(@email_address)
  assert_page('Home')
  assert_logged_in_session
end

Given(/^I have signed in to change my first name$/) do
  @email_address = test_data('emails', 'change_first_name')
  @password = test_data('passwords', 'valid_password')
  sign_in(@email_address, @password)
  assert_page('Home')
end

Given(/^I sign in as a user who has no samples in their account$/) do
  sign_in_page.load
  email = test_data('emails', 'empty_library_no_devices')
  password = test_data('passwords', 'valid_password')
  enter_sign_in_details(email, password)
  click_sign_in_button
end

Given(/^I sign in as a user who has( no)? books? (?:and|or) devices? in their account$/) do |no_books|
  no_books ? @email_address = test_data('emails', 'empty_library_no_devices')  : @email_address = test_data('emails', 'books_in_library_and_devices')
  step('I have signed in')
end

When(/^(?:I sign in|sign in|signed in)(?: to proceed with (?:the purchase|adding sample)?)?$/) do
  sign_in_from_redirected_page
end

When(/^I (?:click|have selected) register (?:button|option)$/) do
  click_register_button
end

When(/^I enter valid personal details$/) do
  @email_address, @first_name, @last_name = enter_personal_details
end

And(/^I choose a valid password$/) do
  enter_password(test_data('passwords', 'valid_password'))
end

And(/^I accept terms and conditions$/) do
  accept_terms_and_conditions(true)
end

And(/^welcome message is shown$/) do
  assert_welcome_message
end

And(/^I submit registration details$/) do
  submit_registration_details
end

When(/^I enter valid sign in details$/) do
  email = test_data('emails', 'happypath_user')
  password = test_data('passwords', 'valid_password')
  @first_name = test_data('name', 'happypath_user')
  enter_sign_in_details(email, password)
end

When(/^select Keep me signed in$/) do
  sign_in_page.remember_me.set true
end

And(/^I click sign in button$/) do
  click_sign_in_button
end

Then(/^I am successfully signed in$/) do
  assert_logged_in_session
  assert_user_greeting_message_displayed(@first_name)
end

Then(/^I should be signed in now$/) do
  home_page.load unless current_page.header.has_account_menu?
  assert_logged_in_session
end

And(/^I am redirected to (.*?) page$/) do |page_name|
  expect_page_displayed(page_name)
end

And(/^I click Sign out button$/) do
  sign_out_from_account_page
end

Then(/^I should be signed out successfully$/) do
  assert_user_greeting_message_not_displayed
end

Given(/^I have multiple stored cards$/) do
  @email_address = test_data('emails', 'multiple_storedcards')
  @first_name = test_data('name', 'multiple_storedcards')
end

Given(/^I register (?:to proceed with the purchase|to proceed with adding sample)$/) do
  click_register_button
  register_new_user
  assert_page("Confirm and pay")
end

Given(/^my default stored card has( not)? expired$/) do |not_expired|
  email = not_expired ? test_data('emails', 'multiple_cards_non_default_expired') : test_data('emails', 'one_default_expired_card')
  set_email_and_password(email, test_data('passwords', 'valid_password'))
end

Given(/^I have multiple saved cards/) do
  #Doing nothing on purpose here as this just makes a good reading for the Steps.
end

When(/^I enter personal details with (valid|invalid) clubcard number$/) do |club_card_type|
  club_card = test_data('clubcards', 'valid_clubcard_number')
  if club_card_type.include?('invalid')
    club_card = test_data('clubcards', 'invalid_clubcard_number')
  end
  @email_address, @first_name, @last_name = enter_personal_details
  register_page.fill_in_club_card(club_card)
end

And(/^I submit registration details by (accepting|not accepting) terms and conditions$/) do |accept_terms|
  if accept_terms.include?('not')
    accept_terms_and_conditions(false)
  else
    accept_terms_and_conditions(true)
  end
  submit_registration_details
end

When(/^I enter registration details with already registered email address$/) do
  @email_address, @first_name, @last_name = enter_personal_details(test_data('emails', 'happypath_user'))
  enter_password(test_data('passwords', 'valid_password'))
end

Then(/^registration is not successful$/) do
  expect_page_displayed('Register')
end

When(/^I enter valid registration details$/) do
  @email_address, @first_name, @last_name = enter_personal_details
  enter_password(test_data('passwords', 'valid_password'))
end

And(/^link to sign in with already registered email address is displayed$/) do
  assert_sign_in_link(@email_address)
end

And(/^type passwords that are less than 6 characters$/) do
  enter_password('test1')
end

And(/^type passwords that are not matching$/) do
  enter_not_matching_passwords
end

But(/^I leave the password field empty$/) do
  enter_password('')
end

Then(/^sign in is not successful$/) do
  expect_page_displayed('sign in')
end

When(/^I try to sign in with not registered email address$/) do
  submit_sign_in_details(test_data('emails', 'dummy_email'), test_data('passwords', 'valid_password'))
end

When(/^I try to sign in with wrong password$/) do
  submit_sign_in_details(test_data('emails', 'happypath_user'), test_data('passwords', 'not_matching_password'))
end

When(/^I try to sign in with email address of invalid format(?:: (.*))?$/) do |invalid_email_address|
  invalid_email_address ||= test_data('emails', 'email_with_no_at')
  submit_sign_in_details(invalid_email_address, test_data('passwords', 'valid_password'))
end

And(/^link to reset password is displayed$/) do
  assert_reset_password_link
end

When(/^I try to sign in with empty (email|password|email and password) fields?$/) do |empty_field|
  email = empty_field.include?('email') ? '' : test_data('emails', 'happypath_user')
  password = empty_field.include?('password') ? '' : 'password'
  submit_sign_in_details(email, password)
end

When(/^I click on Send me a reset link$/) do
  click_forgotten_password_link
end

When(/^I click on Send reset link$/) do
  reset_password_page.send_reset_link.click
end

Given(/^I am returning user(?: with saved payment details)?$/) do
  set_email_and_password(test_data('emails', 'no_expired_cards'), test_data('passwords', 'valid_password'))
end

Given(/^I have attempted to register with already registered email address$/) do
  register_with_existing_email_address
end

When(/^I click on link to sign in with already registered email$/) do
  register_page.sign_in_with_existing_email_link.click
end

Given(/^I have a (?:paid|free) book(?: (?:as a )?sample) in my library$/) do
  set_email_and_password(test_data('emails', 'books_in_library'), test_data('passwords', 'valid_password'))
  @sample = true
end

Given(/^I have purchased a (?:paid|free) book$/) do
  set_email_and_password(test_data('emails', 'books_in_library'), test_data('passwords', 'valid_password'))
  @sample = false
end

Given(/^I am returning user with no (?:associated devices|saved payment cards|orders in the past)$/) do
  set_email_and_password(test_data('emails', 'empty_library_no_devices'), test_data('passwords', 'valid_password'))
end

Given(/^I have (not opted|opted) in for blinkbox books marketing$/) do |opt_status|
  if opt_status.include?('not')
    set_email_and_password(test_data('emails', 'opted_out_marketing'), test_data('passwords', 'valid_password'))
  else
    set_email_and_password(test_data('emails', 'opted_in_marketing'), test_data('passwords', 'valid_password'))
  end
end

When(/^I click on Forgotten your password\? link$/) do
  click_forgotten_password_link
end

When(/^I enter email address (not )?registered with blinkbox books$/) do |not_registered|
  if not_registered
    reset_password_page.email_address.set test_data('emails', 'dummy_email')
  else
    reset_password_page.email_address.set test_data('emails', 'happypath_user')
  end
end

When(/^I enter email address of invalid format(?:: (.*))?$/) do  |invalid_email_address|
  invalid_email_address ||= test_data('emails', 'email_with_no_at')
  reset_password_page.email_address.set invalid_email_address
end

When(/^I enter blank email address$/) do
  reset_password_page.email_address.set ''
end

And(/^reset email confirmation message is displayed$/) do
  assert_reset_email_confirmation
end

Given(/^I have £(\d+) account credit$/) do |account_credit|
  if account_credit.to_i.eql?(5)
    set_email_and_password(test_data('emails', 'five_account_credit'), test_data('passwords', 'valid_password'))
  elsif account_credit.to_i.eql?(50)
    set_email_and_password(test_data('emails', 'fifty_account_credit'), test_data('passwords', 'valid_password'))
  else
    fail "User with #{account_credit} account credit is not available, please add the user to test_data.yml under data folder"
  end
end

Then(/^the page title should be "(.+)"$/) do |title|
  expect(confirm_and_pay_page.title.downcase).to eq(title.downcase)
end

Then(/^I see the personification message showing that I have (some|no) full ebooks? with this account$/) do |books|
  if books == 'no'
    expect(your_account_page.account_message_books).to eq(0)
  else
    expect(your_account_page.account_message_books).to be > 0
  end
end

Then(/^I see the personification message showing that I have (some|no) devices? associated with this account$/) do |devices|
  if devices == 'no'
    expect(your_account_page.account_message_devices).to eq(0)
  else
    expect(your_account_page.account_message_devices).to be > 0
  end
end

Then(/^the promotion checkbox should be ticked by default$/) do
  assert_promotion_checkbox_ticked
end

And(/^I tick the checkbox show password while typing$/) do
  register_page.show_password.set true
end

And(/^I tick the checkbox show password while typing on the Sign in page/) do
  sign_in_page.sign_in_form.show_password.set true
end

When(/^I enter a password$/) do
  enter_password_signin_page(test_data('passwords', 'valid_password'))
end

Then(/^the passwords should( not)? be visible$/) do |password_status|
  if password_status
    expect(register_page.password[:type]).to eq('password')
    expect(register_page.password_repeat[:type]).to eq('password')
  else
    expect(register_page.password[:type]).to eq('text')
    expect(register_page.password_repeat[:type]).to eq('text')
  end
end

Then(/^the password should( not)? be visible on the Sign in page$/) do |password_status|
  if password_status
    expect(sign_in_page.sign_in_form.password[:type]).to eq('password')
  else
    expect(sign_in_page.sign_in_form.password[:type]).to eq('text')
  end
end

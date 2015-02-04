Then(/^Voucher Redemption form should be displayed$/i) do
  voucher_redemption_page.wait_for_voucher_code
  expect(voucher_redemption_page).to have_voucher_code
  expect(voucher_redemption_page).to have_use_this_code_button
end

Given(/^I submit an?(?: invalid| valid)? voucher code "([^"]*)"$/) do |code|
  voucher_redemption_page.submit_code(code)
end

When(/^I confirm the voucher redemption$/) do
  voucher_redemption_page.add_free_credit_button.click
end

Then(/^the redemption confirmation message is displayed$/) do
  voucher_redemption_page.wait_until_start_shopping_button_visible
  expect(voucher_redemption_page.confirmation_message.text).to include("You've now got £5 of free credit to spend!")
end

Then(/^voucher validation error is displayed$/) do
  expect(voucher_redemption_page.validation_error_element).to be_visible
end

Then(/^the Registration form should be displayed$/) do
  expect(voucher_redemption_page.registration_form).to be_displayed
end

When(/^I submit the registration details$/) do
  @first_name = generate_random_first_name
  @last_name = generate_random_last_name
  @email_address = generate_random_email_address
  password = test_data('passwords', 'valid_password')
  voucher_redemption_page.submit_registration_details(@first_name, @last_name, @email_address, password)
end

When(/^I submit the registration details with password less than 6 characters$/) do
  @first_name = generate_random_first_name
  @last_name = generate_random_last_name
  @email_address = generate_random_email_address
  password = 'SNIP'
  voucher_redemption_page.submit_registration_details(@first_name, @last_name, @email_address, password)
end

Then(/^the registration is not successful$/) do
  expect(voucher_redemption_page.registration_form).to be_displayed
  expect(voucher_redemption_page.registration_form.error_element).to be_visible
end

Then(/^the sign in is not successful$/) do
  expect(voucher_redemption_page.sign_in_form).to be_displayed
  expect(voucher_redemption_page.sign_in_form.error_element).to be_visible
end

Then(/^my account should be credited by £(\d+)$/) do |credit_amount|
  redeem_voucher_page.wait_until_start_shopping_button_visible
  expect(voucher_redemption_page.confirmation_message.text).to include("You've now got £#{credit_amount} of free credit to spend!")
end

When(/^I choose to sign in$/) do
  voucher_redemption_page.registration_form.have_an_account.click
end

And(/^I sign in with an exiting account$/) do
  @first_name = test_data('name', 'happypath_user')
  voucher_redemption_page.submit_sign_in_details(test_data('emails', 'happypath_user'), test_data('passwords', 'valid_password'))
end

Given(/^I submit an already used voucher code$/) do
  voucher_redemption_page.submit_code(test_data('vouchers', 'already_used'))
end

But(/^I try and sign in without a password$/) do
  voucher_redemption_page.submit_sign_in_details(test_data('emails', 'happypath_user'), '')
end

When(/^I start to enter a voucher code with special characters$/) do
  voucher_redemption_page.voucher_code.set('123!@£')
end

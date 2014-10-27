When /^I select (.*?) link from drop down menu$/ do |link|
  click_link_from_my_account_dropdown(link)
end

When /^I select sign out from the drop down menu$/ do
  current_page.header.click_log_out
end

And /^(.*?) tab is selected$/ do |tab_name|
  expect_account_tab_selected(tab_name)
end

Given /^I am on the (.*?) tab/ do |tab_name|
  expect_page_displayed('HomePage')
  current_page.header.navigate_to_account_option(tab_name)
end


And /^the Books from the Highlight section are shown/ do
  expect(samples_page).to have_highlights_section
  samples_page.highlights_section.wait_for_books
  expect(samples_page.highlights_section.books).to have_at_least(1).item
end

When /^I edit the first name and last name$/ do
  @first_name, @last_name = edit_personal_details
end

And /^(?:I submit|submit) my personal details$$/ do
  submit_personal_details
end

Then /^the first name and last name are as submitted$/ do
  assert_name_on_personal_details_page(@first_name, @last_name)
end

When /^I edit marketing preferences$/ do
  @after_status = edit_marketing_preferences
end

And /^marketing preferences are as submitted$/ do
  assert_marketing_preferences(@after_status)
end

Given /^I have registered as new user (without|with) a clubcard/ do |provide_clubcard|
  navigate_to_register_form
  @valid_clubcard = test_data('clubcards', 'valid_clubcard_register')
  @current_password, @email_address, @first_name, @last_name = register_new_user(provide_clubcard, @valid_clubcard)
  assert_logged_in_session
end

When /^I edit email address$/ do
  @new_email_address = set_random_email_address
end

And /^email address is as submitted$/ do
  expect(your_personal_details_page.email_address.value).to eq(@new_email_address)
end

And /^I am on the Change your password section$/ do
  show_change_your_password_section
end

When /^I change password$/ do
  @new_password = update_account_password(@current_password, test_data('passwords', 'change_password'))
end

And /^I confirm changes$/ do
  your_personal_details_page.confirm_changes
end

And /^I can sign in with the new password successfully$/ do
  sign_out_and_start_new_session
  sign_in(@email_address, @new_password)
  assert_logged_in_session
end

When /^I delete the first card from the list$/ do
  delete_stored_card(0)
end

Then /^there are no cards in my account$/ do
  assert_number_of_saved_cards(0)
end

When /^I set a different card as my default card$/ do
  pending "CWA-1784: Send boolean to credit card update service" do
    @default_card = set_card_default
  end
end

And /^the selected card is displayed as my default card$/ do
  assert_default_card(@default_card)
end

Then /^(?:my )clubcard (?:added to my account|updated)$/i do
  assert_clubcard(@new_clubcard)
end

When /^I enter new valid clubcard number$/ do
  @new_clubcard = enter_clubcard(test_data('clubcards', 'valid_clubcard_number'))
end

When /^I attempt to update my clubcard with invalid (\d+)$/ do |clubcard_number|
  enter_clubcard(clubcard_number, :submit => true)
end

And /^my clubcard is not updated$/ do
  assert_clubcard @valid_clubcard
end

And /^my email is not updated$/ do
  assert_email_address(@email_address)
end

When /^I attempt to update email address with already registered email address$/ do
  @email_before = update_email_address(test_data('emails', 'happypath_user'))
end

When /^I attempt to update password by providing incorrect current password$/ do
  update_password(test_data('passwords', 'invalid_password'), test_data('passwords', 'change_password'), :submit => true)
end

When /^I attempt to update password by providing not matching passwords$/ do
  update_password(@current_password, test_data('passwords', 'change_password'), test_data('passwords', 'not_matching_password'), :submit => true)
end

When /^I attempt to update password by providing passwords less than 6 characters$/ do
  update_password(@current_password, test_data('passwords', 'five_digit_password'), :submit => true)
end

And /^my password is not updated$/ do
  sign_out_and_start_new_session
  sign_in(@email_address, @current_password)
  assert_logged_in_session
end

When /^I remove clubcard number$/ do
  delete_clubcard
end

When /^I remove first name text$/ do
  delete_first_name
end

When /^I remove last name text$/ do
  delete_last_name
end

When /^I remove email address$/ do
  delete_email_address
end

Then /^my clubcard field is empty$/ do
  refresh_current_page
  assert_clubcard
end

Then /^my marketing preferences checkbox is (not selected|selected)$/ do |marketing_status|
  marketing_status.include?('not') ? status = false : status = true
  assert_marketing_preferences(status)
end

And /^I have a device associated with my blinkbox books account$/ do
  @email_address, @password, @device_name = api_helper.create_new_user!(with_client: "device")
  @device_count = 1
end

When /^I navigate to devices tab of my account$/ do
  click_link_from_my_account_dropdown('Devices')
end

And /^rename my device as "(.*?)"$/ do |new_name|
  rename_device new_name
end


And /^submit changes$/ do
  confirm_rename_device
end

Then /^my device should be renamed to "(.*?)"$/ do |new_name|
  assert_device_name new_name
end

And /^cancel submit changes$/ do
  cancel_rename_device
end

Then /^my device is not renamed$/ do
  assert_device_name @device_name
end

And /^delete my device$/ do
  delete_device
end

And /^confirm delete$/ do
  confirm_delete_device
  @device_count -= 1
end

Then /^I have no devices associated with my account$/ do
  assert_no_devices_present
end

And /^cancel delete device by clicking Keep link$/ do
  cancel_delete_device
end

Then /^my device is not deleted$/ do
  assert_device_count @device_count
end

And /^cancel delete device by closing pop\-up$/ do
  close_delete_device_pop_up
end

And /^I attempt to update password by providing an empty password$/ do
  current = test_data('passwords', 'change_password')
  new = test_data('passwords', 'valid_password')
  supply_new_password(current, '', new)
end

And /^I attempt to update password by providing an empty re-enter password$/ do
  current = test_data('passwords', 'change_password')
  new = test_data('passwords', 'valid_password')
  supply_new_password(current, new, '')
end

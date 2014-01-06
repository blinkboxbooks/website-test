When /^I select (.*?) link from drop down menu$/ do |link|
  click_link_from_my_account_dropdown(link)
end

And /^(.*?) tab is selected$/ do |tab_name|
  expect_account_tab_selected(tab_name)
end


Given /^I am on the (.*?) tab/ do |tab_name|
  click_link_from_my_account_dropdown(tab_name)
end

When /^I edit the first name and last name$/ do
  @first_name, @last_name = edit_personal_details
end

And /^(?:I submit|submit) my personal details$$/ do
  page.should have_button("Update personal details")
  your_personal_details_page.update_personal_details.click
end

Then /^the first name and last name are as submitted$/ do
  your_personal_details_page.first_name.value.should eql(@first_name)
  your_personal_details_page.last_name.value.should eql(@last_name)
end

When /^I edit marketing preferences$/ do
 @after_status = edit_marketing_preferences
end

And /^marketing preferences are as submitted$/  do
  assert_marketing_preferences_changed(@after_status)
end

Given /^I have registered as new user (without|by) providing clubcard/ do |provide_clubcard|
  navigate_to_register_form
  @email_address, @first_name, @last_name = enter_personal_details
  @current_password =  test_data("passwords", "valid_password")
  enter_password(@current_password)
  if provide_clubcard.include?('by')
    @valid_clubcard = test_data('clubcards', 'valid_clubcard_register')
    your_personal_details_page.fill_in_club_card(@valid_clubcard)
  end
  accept_terms_and_conditions(true)
  submit_registration_details
  assert_user_greeting_message_displayed(@first_name)
end

When /^I edit email address$/ do
  @new_email_address = generate_random_email_address
  fill_form_element('email', @new_email_address)
end

And /^email address is as submitted$/  do
  find('[id="email"]').value.should.eql?(@new_email_address)
end

And /^I am on the Change your password section$/ do
  click_link_from_my_account_dropdown('Your personal details')
  find('.arrowedlink').click
end

When /^I change password$/ do
  @new_password = test_data('passwords', 'change_password')
  update_password(@current_password,@new_password)
end

And /^I confirm changes$/ do
  click_button('Confirm')
  page.has_selector?('#ind_details')
  page.has_content?('Signing in to your account')
end

And /^I can sign in with the new password successfully$/ do
  sign_out_and_start_new_session
  sign_in(@email_address,@new_password)
end

When /^I delete the first card from the list$/ do
  within('.payment_list') do
    within(first('li')) do
     find('a').click
    end
  end
  click_button('Delete')
end

Then /^there are no cards in my account$/ do
  within('.payment_list') do
    page.all('li').count.eql?(0)
  end
end

When /^I set a different card as my default card$/ do
    @default_card = set_card_default
end

And /^the selected card is displayed as my default card$/ do
    click_link('Featured')
    click_link_from_my_account_dropdown('Your payments')
    assert_default_card(@default_card)
end

When /^I enter valid clubcard number$/ do
  @valid_clubcard = test_data('clubcards', 'valid_clubcard_number')
  your_personal_details_page.fill_in_club_card(@valid_clubcard)
end

Then /^clubcard added to my account$/ do
  expect(your_personal_details_page.club_card.value).to eq(@valid_clubcard.to_s)
end

Then /^my clubcard updated$/ do
  expect(your_personal_details_page.club_card.value).to eq(@valid_clubcard.to_s)
end

When /^I attempt to update my clubcard with invalid (\d+)$/ do |clubcard_number|
  @club_card_before = your_personal_details_page.club_card.value
  your_personal_details_page.fill_in_club_card(clubcard_number)
  your_personal_details_page.update_personal_details.click
end

And /^my clubcard is not updated$/ do
  click_link('Featured')
  click_link_from_my_account_dropdown('Your personal details')
  your_personal_details_page.club_card.value.should eql(@club_card_before)
end

And /^my email is not updated$/ do
  click_link('Featured')
  click_link_from_my_account_dropdown('Your personal details')
  your_personal_details_page.email_address.value.should eql(@email_before)
end

When /^I attempt to update email address with already registered email address$/ do
  @email_before = your_personal_details_page.email_address.value
  your_personal_details_page.email_address.set(test_data('emails', 'happypath_user'))
  your_personal_details_page.update_personal_details.click
end

When /^I attempt to update password by providing incorrect current password$/ do
  update_password(test_data('passwords', 'invalid_password'), test_data('passwords', 'change_password'))
  change_password_page.confirm_button.click
end

When /^I attempt to update password by providing not matching passwords$/ do
  update_password(@current_password, test_data('passwords', 'change_password'),test_data('passwords', 'not_matching_password'))
  change_password_page.confirm_button.click
end

When /^I attempt to update password by providing passwords less than 6 characters$/ do
  update_password(@current_password,test_data('passwords', 'five_digit_password'))
  change_password_page.confirm_button.click
end

And /^my password is not updated$/ do
  sign_out_and_start_new_session
  sign_in(@email_address,@current_password)
  assert_user_greeting_message_displayed(@first_name)
end






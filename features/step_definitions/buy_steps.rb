When /^I enter valid (.*?) card details$/ do |card_type|
  enter_card_details(set_valid_card_details(card_type))
end

And /^I enter valid Billing address$/ do
  enter_billing_details
end

And /^I submit payment details$/ do
  click_confirm_and_pay
end

When /^I pay with saved default card$/ do
  pay_with_saved_card
end

When /^I choose to pay with a new card$/ do
  click_pay_with_new_card
end

And /^I have identified a (free|paid) book on the (book details|search results) page to read sample offline$/ do |book_type, page|
  select_book_to_add_as_sample(book_type, page.gsub(' ', '_').to_s)
end

When /^I click Confirm order$/ do
  click_confirm_order
end

Given /^I (?:am buying|click Buy now on) a (paid|free) book as a (not logged|logged) in user$/i do |book_type, login_status|
  if login_status.eql?('logged')
    sign_in
  elsif logged_in_session?
    log_out_current_session
  end
  select_book_to_buy(book_type.downcase.to_sym)
end

When /^I pay with a new (.*?) card$/ do |card_type|
  click_pay_with_new_card
  enter_card_details(set_valid_card_details(card_type))
  enter_billing_details
end

And /^I choose (to save|not to save)(?: new)? payment details$/ do |save_payment|
  save_payment.include?('not') ? save_card(false) : save_card(true)
end

Then /^(?:my payment|adding sample) is successful$/ do
  expect_page_displayed('order complete')
  assert_order_complete
end

When /^I select Read offline on the book details page$/ do
  click_read_offline
end

When /^I select the above book to buy$/ do
  buy_sample_added_book
end

And /^Confirm and pay button should be (enabled|disabled)$/ do |button_status|
  assert_confirm_and_pay_button_status(button_status)
end

When /^I cancel (order|registration)$/ do |cancel_action|
  cancel_action.include?('registration') ? cancel_registration : cancel_order
end

And /^confirm cancel (order|registration)$/ do |confirm_action|
  confirm_action.include?('registration') ? confirm_cancel_registration : confirm_cancel_order
end

Given /^I have selected to buy a (paid|free) book from (Bestsellers|New releases|Free eBooks|Home|Category|Search results|Book details) page$/i do |book_type, page_name|
  @book_title = select_book_to_buy_from(page_name, book_type)
end

Given /^I have selected to buy a (paid|free) book$/ do |book_type|
  @book_title = select_book_to_buy(book_type.to_sym)
end

And /^my payment failed at Braintree for not matching CVV$/ do
  confirm_and_pay_page.pay_with_new_card.click
  submit_new_payment_with_not_matching_cvv
  assert_payment_failure_message
end

And /^I have validation error messages on the page$/ do
  submit_empty_new_payments_form
end

When /^I select above (paid|free) book to buy$/ do |book_type|
  book_type.include?('free') ? select_book_by_isbn_to_buy(book_type.to_sym, test_data('library_isbns', 'free_book')) : select_book_by_isbn_to_buy(book_type.to_sym, test_data('library_isbns', 'pay_for_book'))
end

And /^(book|sample) already exists in the library message displayed in confirm and pay page$/ do |type|
  assert_book_exists_in_library_message(type)
end

When /^I select above (paid|free) book to add sample$/ do |book_type|
  # TODO: Search for usage
  book_type.include?('free') ? select_book_by_isbn_to_read(book_type.to_sym, test_data('library_isbns', 'free_sample')) : select_book_by_isbn_to_read(book_type.to_sym, test_data('library_isbns', 'pay_for_sample'))
end

And /^payment failure message should be displayed$/ do
  assert_payment_failure_message
end

And /^I submit payment details with not matching cvv (\d+)$/ do |cvv_number|
  submit_new_payment_with_not_matching_cvv(cvv_number)
end

And(/^submit the payment details with empty credit card form$/) do
  submit_payment_details_with_empty_cc_form
end

And /^submit the payment details with empty (Name on card|Card number|CVV)$/ do |card_field|
  submit_incomplete_payment_details(card_field)
end

And /^submit the payment details with empty (Address line one|Town or city|Postcode)$/ do |address_field|
  submit_incomplete_billing_details(address_field)
end

And /^submit the payment details with numeric input only for (Address line one|Address line two|Town or city|Postcode)$/ do |address_field|
  submit_incorrect_numeric_billing_details(address_field)
end

And /^submit the payment details with malformed post code (.*?)$/ do |value|
  submit_malformed_post_code(value)
end

Then /^my payment is not successful$/ do
  expect(confirm_and_pay_page).to be_displayed
end

And /^submit the payment details with expiry date in the past$/ do
  submit_payment_details_with_past_expiry_date
end

And(/^following validation error messages are displayed for credit card details:$/) do |table|
  assert_validation_error_messages(table)
end

And(/^submit the payment details with not supported card type (.*?)$/) do |card_type|
  submit_payment_details_with_card_type(card_type)
end

And(/^submit the payment details with a malformed cvv (.*?)$/) do |cvv|
  submit_payment_details_with_cvv(cvv)
end

When /^I complete purchase by selecting (to save|not to save) the card details$/ do |save_payment|
  if save_payment.include?('not')
    @name_on_card, @card_type = successful_new_payment(save_payment = false)
  else
    @name_on_card, @card_type = successful_new_payment(save_payment = true)
    @card_count = 1
  end
end

Then /^I can see this book in my Order & Payment history$/ do
  click_link_from_my_account_dropdown('Order history')
  assert_book_order_and_payment_history(@book_title)
end

When /^I complete purchase by paying with saved card$/ do
  pay_with_saved_card
end

Then /^I can see the payment card saved in my Payment details$/ do
  click_link_from_my_account_dropdown('Saved cards')
  assert_payment_card_saved(@card_count, @name_on_card, @card_type)
end

When /^I complete purchase with new card by selecting (to save|not to save) Payment details$/ do |save_payment|
  confirm_and_pay_page.pay_with_new_card.click

  if save_payment.include?('not')
     successful_new_payment(save_payment = false)
  else
    @name_on_card, @card_type = successful_new_payment(save_payment = true)
    @card_count += 1
  end
end

And /^I have a stored card$/ do
  @email_address, @password = api_helper.create_new_user!
  @name_on_card = api_helper.add_credit_card
  @card_type = 'VISA'
  @card_count = 1
end

And /^submit the payment details with cvv (\d+) for (.*?) card$/ do |cvv, card_type|
  submit_payment_details_with_cvv(cvv, card_type)
end

And /^submit the payment details with card number (\d+)$/ do |card_number|
  submit_payment_details_with_card_number(card_number)
end

Then /^I have no saved payment cards in my account$/ do
  click_link_from_my_account_dropdown('Saved cards')
  expect(your_payments_page).to have_no_saved_cards_container
end

Then /^my saved Payment details are not updated$/ do
  click_link_from_my_account_dropdown('Saved cards')
  assert_payment_card_saved(@card_count,@name_on_card, @card_type)
end

Then /^Confirm and pay page displays my account credit as £(\d+)$/ do |account_credit|
  assert_credit_on_confirm_pay_page(account_credit)
end

And /^my payment method is account credit$/ do
  assert_payment_method(:credit)
end

And /^amount left to pay is displayed$/ do
   assert_amount_left_to_pay(@account_credit, @book_price)
end


And /^my payment method is partial payment$/ do
  assert_payment_method(:partial)
end

When /^I (?:select|selected) a book to (?:buy from Search results |buy )with price (more|less) than £(\d+)$/ do |condition, price|
  @account_credit = price
  @book_price = buy_book_by_price(condition, @account_credit)
end

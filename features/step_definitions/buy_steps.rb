When(/^I enter valid (.*) card details$/) do |card_type|
  enter_card_details(set_valid_card_details(card_type))
end

And(/^I enter valid Billing address$/) do
  enter_billing_details
end

And(/^I submit the payment details$/) do
  click_confirm_and_pay
end

When(/^I pay with my saved default card$/) do
  pay_with_saved_card
end

When(/^I choose to pay with a new card$/) do
  choose_to_pay_with_a_new_card
end

And(/^I have identified a (free|paid) book on the (book details|search results) page to read sample offline$/) do |book_type, page|
  select_book_to_add_as_sample(book_type, page.gsub(' ', '_').to_sym)
end

And(/^I have identified the same (free|paid) book to read offline as a sample$/) do |book_type|
  step("I have identified a #{book_type} book on the book details page to read sample offline")
end

When(/^I click on Confirm order$/) do
  click_confirm_order
end

Given(/^I (?:am buying|click Buy now on) a (paid|free) book as a (not logged|logged) in user$/i) do |book_type, login_status|
  unless login_status.include?('not')
    sign_in
    assert_page('Home')
  end
  select_book_to_buy(book_type.downcase.to_sym)
end

When(/^I pay with a new (.*?) card$/) do |card_type|
  choose_to_pay_with_a_new_card
  enter_card_details(set_valid_card_details(card_type))
  enter_billing_details
end

And(/^I choose (to save|not to save) the(?: new)? payment details$/) do |save_payment|
  save_payment.include?('not') ? save_card(false) : save_card(true)
end

Then(/^(?:my payment|adding sample) is successful$/) do
  expect_page_displayed('order complete')
  assert_order_complete
end

When(/^I select Read offline on the book details page$/) do
  click_read_offline
end

When(/^I try to add the book as a sample again$/) do
  step('I select Read offline on the book details page')
end

When(/^I select the above book to buy$/) do
  buy_sample_added_book
end

And(/^Confirm and pay button should be (enabled|disabled)$/) do |button_status|
  assert_confirm_and_pay_button_status(button_status)
end

When(/^I cancel (order|registration)$/) do |cancel_action|
  cancel_action.include?('registration') ? cancel_registration : cancel_order
end

And(/^confirm cancel (order|registration)$/) do |confirm_action|
  confirm_action.include?('registration') ? confirm_cancel_registration : confirm_cancel_order
end

Given(/^I have selected to buy a (paid|free) book from(?: the)? (Bestsellers|New releases|Free eBooks|Home|Category|Search results|Book details) page$/i) do |book_type, page_name|
  @book_title = select_book_to_buy_from(page_name, book_type)
end

Given(/^I am on the Confirm and pay page trying to buy a (paid|free) book$/i) do |book_type|
  @book_title = select_book_to_buy_on('Book details', book_type)
  sign_in_from_redirected_page
  assert_page("Confirm and pay")
end

Given(/^I have selected to buy a free book( via search)?$/) do |do_search|
  if do_search
    @book_title = select_book_to_buy(book_type.to_sym)
  else
    free_ebooks_page.load
    books_section.click_buy_now_free_book
  end
end

Given(/^I have selected to buy a paid book$/) do
  @book_title = select_book_to_buy(:paid)
end

Given(/^I have selected to buy a (free) book from Grid view$/) do |book_type|
  @book_title = select_book_from_grid_view(book_type.to_sym)
end

And(/^my payment failed at Braintree for not matching CVV$/) do
  confirm_and_pay_page.pay_with_new_card.click
  submit_new_payment_with_not_matching_cvv
  assert_payment_failure_message
end

And(/^I have validation error messages on the page$/) do
  submit_empty_new_payments_form
end

And(/^(book|sample) already exists in the library message is displayed on the confirm and pay page$/) do |type|
  assert_book_exists_in_library_message(type)
end

And(/^payment failure message should be displayed$/) do
  assert_payment_failure_message
end

And(/^I submit the payment details with not matching cvv (\d+)$/) do |cvv_number|
  submit_new_payment_with_not_matching_cvv(cvv_number)
end

And(/^submit the payment details with empty credit card form$/) do
  submit_payment_details_with_empty_cc_form
end

And(/^submit the payment details with empty (Name on card|Card number|CVV)$/) do |card_field|
  submit_incomplete_payment_details(card_field)
end

And(/^submit the payment details with empty (Address line one|Town or city|Postcode)$/) do |address_field|
  submit_incomplete_billing_details(address_field)
end

And(/^submit the payment details with numeric input only for (Address line one|Address line two|Town or city|Postcode)$/) do |address_field|
  submit_incorrect_numeric_billing_details(address_field)
end

And(/^submit the payment details with malformed post code (.*?)$/) do |value|
  submit_malformed_post_code(value)
end

Then(/^my payment is not successful$/) do
  expect(confirm_and_pay_page).to be_displayed
end

And(/^submit the payment details with expiry date in the past$/) do
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

Then(/^I can see this book in my Order & Payment history$/) do
  click_link_from_my_account_dropdown('Order history')
  assert_book_order_and_payment_history(@book_title)
end

When(/^I complete purchase by paying with saved card$/) do
  @card_count = pay_with_saved_card
end

Then(/^I can see the payment card saved in my Payment details$/) do
  click_link_from_my_account_dropdown('Saved cards')
  assert_payment_card_saved(@card_count, @name_on_card, @card_type)
end

When(/^I complete purchase with new card by selecting (to save|not to save) Payment details$/) do |save_payment|
  if save_payment.include?('not')
    not_saved_name, not_saved_card_type, @card_count = successful_new_payment(save_payment: false)
  else
    @name_on_card, @card_type, @card_count = successful_new_payment(save_payment: true)
  end
end

And(/^I have a stored card$/) do
  @email_address, @password = api_helper.create_new_user!
  card_details = api_helper.add_credit_card
  @name_on_card = card_details['cardholderName']
  @card_type = card_details['cardType'].upcase
end

And(/^submit the payment details with cvv (\d+) for (.*?) card$/) do |cvv, card_type|
  submit_payment_details_with_cvv(cvv, card_type)
end

And(/^submit the payment details with card number (\d+)$/) do |card_number|
  submit_payment_details_with_card_number(card_number)
end

Then(/^I have no saved payment cards in my account$/) do
  click_link_from_my_account_dropdown('Saved cards')
  expect(your_payments_page).to have_no_saved_cards_container
end

Then(/^my saved Payment details are not updated$/) do
  click_link_from_my_account_dropdown('Saved cards')
  assert_payment_card_saved(@card_count, @name_on_card, @card_type)
end

Then(/^Confirm and pay page displays my account credit as £(\d+)$/) do |account_credit|
  assert_credit_on_confirm_pay_page(account_credit)
end

And(/^my payment method is account credit$/) do
  assert_payment_method(:credit)
end

And(/^amount left to pay is displayed$/) do
  assert_amount_left_to_pay(@account_credit, @book_price)
end

And(/^my payment method is partial payment$/) do
  assert_payment_method(:partial)
end

When(/^I (?:select|selected) a book to (?:buy from Search results |buy )with price (more|less) than £(\d+)$/) do |condition, price|
  @account_credit = price
  @book_price = buy_book_by_price(condition, @account_credit)
end

When(/^I click buy now on book details page$/i) do
  book_details_page.buy_book
end

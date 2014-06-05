Given /I have identified a best selling book to buy$/ do
  select_book_to_buy_from('Bestsellers', :paid)
end

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

And /^I have identified a (free|paid) book to read sample offline$/ do |book_type|
  select_book_to_view_details(book_type.to_sym)
end

When /^I click Confirm order$/ do
  click_confirm_order
end

Given /^I (?:am buying|click Buy now on) a (pay for|free) book as a (not logged|logged) in user$/ do |book_type, login_status|
  if login_status.eql?('logged')
    sign_in
  else
    if logged_in_session?
      log_out_current_session
    end
  end
  select_book_to_buy_from('Search results', :paid)
end

When /^I pay with a new (.*?) card$/ do |card_type|
  click_pay_with_new_card
  enter_card_details(set_valid_card_details(card_type))
  enter_billing_details
end

And /^I choose (to save|not to save)(?: new)? payment details$/ do |save_payment|
  if save_payment.include?('not')
    save_card(false)
  else
    save_card(true)
  end
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
  if cancel_action.include?('registration')
    cancel_registration
  else
    cancel_order
  end
end

And /^confirm cancel (order|registration)$/ do |confirm_action|
  if confirm_action.include?('registration')
    confirm_cancel_registration
  else
    confirm_cancel_order
  end
end

Given /^I have selected to buy a (pay for|free) book from (Bestsellers|New releases|Free eBooks|Home|Category|Search results|Book details) page$/ do |book_type, page_name|
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

When /^I select above (pay for|free) book to buy$/ do |book_type|
  isbn = test_data('library_isbns', 'pay_for_book')
  if book_type.include?('free')
    isbn = test_data('library_isbns', 'free_book')
  end
  search_blinkbox_books isbn
  books_section.books[0].click_view_details
  book_details_page.wait_for_buy_now
  book_details_page.buy_now.click
end

And /^(book|sample) already exists in the library message displayed in confirm and pay page$/ do |type|
  expect(find('#already-purchased')).to be_visible
  expect(page).to have_text("You already have this #{type} in your library")
end

When /^I select above (pay for|free) book to add sample$/ do |book_type|
  isbn = test_data('library_isbns', 'pay_for_sample')
  if book_type.include?('free')
    isbn = test_data('library_isbns', 'free_sample')
  end
  search_blinkbox_books isbn
  books_section.books[0].click_view_details
  click_read_offline
end

And /^payment failure message should be displayed$/ do
  assert_payment_failure_message
end

And /^I submit payment details with not matching cvv (\d+)$/ do |cvv_number|
  submit_new_payment_with_not_matching_cvv(cvv_number)
end

And(/^submit the payment details with empty credit card form$/) do
  enter_billing_details
  confirm_and_pay_page.wait_for_confirm_and_pay
  confirm_and_pay_page.confirm_and_pay.click
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
  table.hashes.each do |row|
    expect(page).to have_content row['Error message']
  end
end

And(/^submit the payment details with not supported card type (.*?)$/) do |card_type|
  enter_card_details(set_valid_card_details(card_type))
  enter_billing_details
  confirm_and_pay_page.wait_for_confirm_and_pay
  confirm_and_pay_page.confirm_and_pay.click
end

And(/^submit the payment details with a malformed cvv (.*?)$/) do |cvv|
  card_details = set_valid_card_details('VISA')
  card_details[:cvv] = cvv
  enter_card_details(card_details)
  enter_billing_details
  confirm_and_pay_page.confirm_and_pay.click
end

When /^I complete purchase by selecting (to save|not to save) the card details$/ do |save_payment|
  if save_payment.include?('not')
    @name_on_card, @card_type = successful_new_payment(save_payment = false)
  else
    @name_on_card, @card_type = successful_new_payment(save_payment = true)
    @card_count = 1;
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
  assert_payment_card_saved(@card_count,@name_on_card, @card_type)
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
  card_details = set_valid_card_details(card_type)
  card_details[:cvv] = cvv
  enter_card_details(card_details)
  enter_billing_details
  confirm_and_pay_page.confirm_and_pay.click
end

And /^submit the payment details with card number (\d+)$/ do |card_number|
  card_details = set_valid_card_details('VISA')
  card_details[:card_number] = card_number
  enter_card_details(card_details)
  enter_billing_details
  confirm_and_pay_page.confirm_and_pay.click
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
  expect(confirm_and_pay_page).to have_account_credit_payment
  expect(confirm_and_pay_page).to have_no_card_payment
end

And /^amount left to pay is displayed$/ do
   assert_amount_left_to_pay(@account_credit, @book_price)
end


And /^my payment method is partial payment$/ do
  expect(confirm_and_pay_page).to have_account_credit_payment
  expect(confirm_and_pay_page).to have_card_payment
end

When /^I (?:select|selected) a book to (?:buy from Search results |buy )with price (more|less) than £(\d+)$/ do |condition, price|
  @account_credit = price
  @book_price = buy_book_by_price(condition, @account_credit)
end

Given /^I have selected a free book to buy from book details$/ do
  select_book_to_buy_from('Book details', 'Free')
end

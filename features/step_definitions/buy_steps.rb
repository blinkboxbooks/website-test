Given /I have identified a best selling book to buy$/ do
  click_buy_now_best_seller_book
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

And /^I have identified a (free|pay for) book to (buy|read sample offline)$/ do |book_type, user_action|
  search_word = return_search_word_for_book_type(book_type)
  if user_action.include?('buy')
    user_selects_a_book_to_buy(search_word)
  else
    user_navigates_to_book_details(search_word)
  end
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
  search_word = return_search_word_for_book_type(book_type)
  user_selects_a_book_to_buy(search_word)
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

Given /^I have selected to buy a (pay for|free) book from (.*?) page$/ do |book_type,page_name|
  @book_title = select_book_to_buy_from_a_page(book_type, page_name)
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
  user_navigates_to_book_details(isbn)
  book_details_page.buy_now.click
end

And /^(book|sample) already exists in the library message displayed in confirm and pay page$/ do |type|
  find('#already-purchased').should be_visible
  page.should have_text("You already have this #{type} in your library")
end

When /^I select above (pay for|free) book to add sample$/ do |book_type|
  isbn = test_data('library_isbns', 'pay_for_sample')
  if book_type.include?('free')
    isbn = test_data('library_isbns', 'free_sample')
  end
  user_navigates_to_book_details(isbn)
  click_read_offline
end

And /^payment failure message should be displayed$/ do
  assert_payment_failure_message
end

And /^I submit payment details with not matching cvv (\d+)$/ do |cvv_number|
  submit_new_payment_with_not_matching_cvv(cvv_number)
end

Then /^my payment is not successful$/ do
  expect_page_displayed('Confirm and pay')
end

And(/^submit the payment details with empty credit card form$/) do
  enter_billing_details
  confirm_and_pay_page.wait_for_confirm_and_pay
  confirm_and_pay_page.confirm_and_pay.click
end

And(/^following validation error messages are displayed for credit card details:$/) do |table|
  table.hashes.each do |row|
    page.should have_content row['Error message']
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
  click_link_from_my_account_dropdown('Order & payment history')
  assert_book_order_and_payment_history(@book_title)
end

When /^I complete purchase by paying with saved card$/ do
  pay_with_saved_card
end

Then /^I can see the payment card saved in my Payment details$/ do
  click_link_from_my_account_dropdown('Your payments')
  assert_payment_card_saved(@card_count,@name_on_card, @card_type)
end

When /^I complete purchase with new card by selecting (to save|not to save) Payment details$/ do |save_payment|
  confirm_and_pay_page.pay_with_new_card.click

  if save_payment.include?('not')
    @name_on_card, @card_type = successful_new_payment(save_payment = false)
  else
    @name_on_card, @card_type = successful_new_payment(save_payment = true)
    @card_count += 1
  end
end

And /^I have a stored card$/ do
  visit('/')
  navigate_to_register_form
  register_new_user
  expect_page_displayed("Registration Success")
  buy_first_book
  @card_count = 1
  log_out_current_session
  set_start_cookie_accepted
end



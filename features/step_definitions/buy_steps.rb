Given /^I have identified the book to buy$/ do
  returning_user_selects_a_book('summer')
end

Given /I have identified a best selling book to buy$/ do
  click_buy_now_best_seller_book
end

When /^I enter valid (.*?) card details$/ do |card_type|
    enter_new_payment_details(card_type)
end

And /^I enter valid Billing address$/  do
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

And /^I choose not to save the payment details$/ do
  uncheck('save_details')
end

And /^I have identified a free book to buy$/ do
  returning_user_selects_a_book('free')
end

When /^I click Confirm order$/ do
  click_confirm_order
end

Given /^I am buying a (pay for|free) book as a (not logged|logged) in user$/ do |book_type, login_status|

  if login_status.eql?('logged')
    sign_in
  else
    if !(Capybara.current_session.driver.browser.manage.cookie_named('access_token').nil?)
      Capybara.current_session.reset_session!
    end
  end
  returning_user_selects_a_book(book_type)

end

When /^I pay with a new (.*?) card$/ do |card_type|
  click_pay_with_new_card
  enter_new_payment_details(card_type)
  enter_billing_details
end

And /^I choose (to save|not to save)(?: new)? payment details$/ do |save_payment|
  if save_payment.include?('not')
    choose_not_to_save_card_details
  else
    choose_to_save_card_details
  end

end

Then /^my payment is successful$/ do
  expect_page_displayed('order complete')
  assert_order_complete_message
end


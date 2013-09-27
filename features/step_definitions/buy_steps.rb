Given /^I have identified the book to buy$/ do
 visit('#!/book/9781448184668')
 click_buy_now_in_book_details
end

Given /^I choose to register$/ do
  click_register_button
end

When /^I enter valid New card details$/ do
    enter_new_payment_details('VISA')
end

When /^I complete registration successfully$/ do
  register_new_user
end

And /^I enter valid Billing address$/  do
    enter_billing_details
end

And /^click Confirm & pay button$/ do
   click_confirm_and_pay
end

When /^I sign in successfully$/ do
  sign_in('bkm3@aa.com','test1234')
end

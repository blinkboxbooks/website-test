When /^I select (.*?) link from drop down menu$/ do |link|
  click_link_from_my_account_dropdown(link)
end

And /^(.*?) tab is selected$/ do |tab_name|
  assert_tab_selected(tab_name)
end


Given /^I am on the Your personal details page$/ do

  #assert_tab_selected(tab_name)
  #click_link_from_my_account_dropdown(link)

  #click_link_from_my_account_dropdown("Your personal details")

  #go to My Account
  #click Your personal details
end

When /^I edit the first name and last name$/ do
  #within() fill_in('first_name', : with => 'Test')
  #fill_in('last_name', : with => 'Change')
  #id=first_name

  #id=last_name

  @first_name, @last_name = edit_personal_details
  pending
end

And /^I submit my personal details$$/ do
  #click Update button
  pending
end

Then /^"Your personal details have been successfully updated" message is displayed$/ do
  #check message element is displayed
  #assert message text
  pending
end

When /^I go to Your personal details page$/ do
  click_link_from_my_account_dropdown("Your personal details")
  #go to My Account
  #click Your personal details
end

Then /^the first name and last name are as submitted$/ do
  #assert value of first name == @first_name
  #assert value of last name == @last_name
  pending
end
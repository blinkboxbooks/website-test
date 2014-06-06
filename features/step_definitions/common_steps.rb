Then /^"(.*?)" message is displayed$/ do |message_text|
  assert_message_displayed(message_text)
end

When /^I click on the (.*) author link from footer$/ do |author_name|
  click_author_link_on_footer(author_name)
end

When /^I click on the (.*) category link from footer$/ do |category_name|
  click_category_link_on_footer(category_name)
end
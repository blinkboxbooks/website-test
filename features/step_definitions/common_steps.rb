Then /^"(.*?)" message is displayed$/ do |message_text|
  page.should have_content(message_text)
end
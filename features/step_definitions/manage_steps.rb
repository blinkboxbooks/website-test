When /^I select (.*?) link from drop down menu$/ do |link|
  click_link_from_my_account_dropdown(link)
end

And /^(.*?) tab is selected$/ do |tab_name|
  assert_tab_selected(tab_name)
end
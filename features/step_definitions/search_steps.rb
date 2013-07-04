#And /^search suggestions (?:should|should not) be displayed$/ do
#
#end

And(/^I search for "(.*?)"$/) do |term|
  fill_in('term', :with => "#{term}")
  click_button('submit_desk')
end

Then(/^I should have a result page with term "(.*?)" matching$/) do |term|
  sleep 5
  find('[data-test="search-results-list"]').text.should include("#{term}".titleize)
end

And(/^the result is displayed in Grid mode$/) do
  find('[data-test="list-button"]').visible?.should == true
end

And(/^I should see the sort option drop down$/) do
  find('div.orderby').find('div.item').find('a.ng-binding').visible?.should == true
end

Given(/^I change from Grid mode to List mode$/) do
  find('[data-test="list-button"]').click
end

And(/^the result should be displayed in Grid mode$/) do
  find('[data-test="grid-button"]').visible?.should == true
end

And(/^the result should be displayed in List mode$/) do
  find('[data-test="list-button"]').visible?.should == true
end

When(/^I change from List mode to Grid mode$/) do
  sleep 15
  find('[ata-test="grid-button"]').click
end

And(/^the number books on List mode should be "(.*?)"$/) do |arg1|

end

Then(/^I should get a message which contains "(.*?)"$/) do |arg1|

end

And(/^the list mode grid mode and sorting options should not appear$/) do

end

And(/^(\d+) Bestselling books should be returned$/) do |arg1|

end

And(/^the number books on List mode should be "(.*?)"$/) do |arg1|

end

And(/^the Tesco clubcard logo should be visible$/) do

end

And(/^I take the number books on Grid mode$/) do

end

And(/^I take the number books on List mode$/) do

end

And(/^the number of books should match on both mode$/) do

end


And(/^press return or click the search button$/) do

end

Given(/^I type "(.*?)" value in the search text box$/) do |arg1|

end

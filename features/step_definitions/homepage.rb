Then /^main footer is displayed$/ do
 (find('[data-test="footer-container"]').visible?).should == true
end



When /^number of banners is between (\d+) and (\d+)$/ do |min_banners, max_banners|
 @min_banners = min_banners
 @max_banners = max_banners
end

Then /^homepage hero banner is displayed$/ do
  pending
end

And /^homepage hero banner should have images$/ do
  pending
end

And /^homepage hero banner should have navigation buttons$/ do
  pending
end

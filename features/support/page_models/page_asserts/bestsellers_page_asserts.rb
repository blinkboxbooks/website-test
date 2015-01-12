Then(/^I should see Promotions section header as (.+)$/) do |title|
  expect(bestsellers_page.daily_bestsellers_title).to eq(title)
end

Then(/^I should see (\d+) books being displayed$/) do |books|
  expect(bestsellers_page.daily_bestsellers.books).to have(books).items
end

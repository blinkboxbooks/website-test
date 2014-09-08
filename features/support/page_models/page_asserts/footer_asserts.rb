Then /^the same Top authors are displayed in the footer$/ do
  current_page.footer.top_authors.each do |author_link|
    expect(@featured_authors).to include(author_link.text)
  end
end

Then /^the same Top categories are displayed in the footer$/ do
  current_page.footer.top_categories.each do |category|
    expect(@top_categories).to include(category.text)
  end
end

Then /^the same New releases are displayed in the footer$/ do
  current_page.footer.new_releases.each do |book_title|
    expect(@new_releases).to include(book_title.text.upcase)
  end
end

Then /"(Discover|Register|Download|Read)" step is displayed on the footer/ do |step|
  step = current_page.footer.step_by_title(step)
  expect(step).to have_image
  expect(step.image).to be_visible
end
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

Then /the new (Help & Support|How it Works|Tesco Clubcard|Redeem Code) footer section should be displayed/ do |step|
  expect(current_page.footer.step_by_title(step)).not_to be_nil
end

Then /I scroll down to the footer/ do
  # Do nothing on purpose. This step is just to improve clarity.
end
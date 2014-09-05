Then /^the top authors on the footer is generated from featured authors section$/ do
  featured_authors = authors_page.featured_authors_names

  current_page.footer.top_authors.each do |author_link|
    expect(featured_authors).to include(author_link.text)
  end
end

Then /^the top categories on the footer is generated from top categories section$/ do
  top_categories = categories_page.top_categories_titles

  current_page.footer.top_categories.each do |category|
    expect(top_categories).to include(category.text)
  end
end

Then /^the new releases on the footer is generated from new releases section$/ do
  new_releases = new_releases_page.new_releases_titles

  current_page.footer.new_releases.each do |book_title|
    expect(new_releases).to include(book_title.text.upcase)
  end
end

Then /"(Discover|Register|Download|Read)" step is displayed on the footer/ do |step|
  step = current_page.footer.step_by_title(step)
  expect(step).to have_image
  expect(step.image).to be_visible
end
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

Then /the (Help & Support|How it Works|Tesco Clubcard|Redeem Code) footer visual should be displayed/i do |footer_visual|
  expect(current_page.footer.visual_by_title(footer_visual)).not_to be_nil
end

When /I look at the footer/ do
  # Do nothing on purpose. This step is just to improve clarity.
end

Then /^the footer copyright text should be displayed$/i do
  expect(current_page.footer).to have_copyright_label
  expect(current_page.footer.copyright_text).to include('blinkbox books')
  expect(current_page.footer.copyright_text).to include('All Rights Reserved')
end

Then /^footer visuals should not be displayed$/i do
  expect(current_page.footer).not_to have_visuals
end

Then /^footer links should not be displayed$/i do
  expect(current_page.footer).not_to have_links
end

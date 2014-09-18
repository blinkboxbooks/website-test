Given /^I am on the home page/ do
  home_page.load unless home_page.displayed?
end

##############################################################
# testing header
##############################################################

When /^I click on the website logo$/ do
  current_page.header.logo.click
end

##############################################################
# testing main navigation
##############################################################

Then /^(?:the )?([\-&\w\s]*) page is displayed$/i do |page_name|
  expect_page_displayed(page_name)
end

##############################################################
# testing footer links
##############################################################

Given /^the blinkbox books help link is present in the footer$/ do
  expect(current_page.footer.links).to have_help
  @help_link = current_page.footer.links.help
end

Then /^the link should point to the blinkbox books help home page$/ do
  expect(@help_link[:href]).to include('http://tiny.cc/s00amix')
  expect(@help_link[:target]).to eq('_blank')
  expect(@help_link.text).to eq('Help')
end

Given /^the blinkbox movies link is present in the footer$/ do
  expect(current_page.footer.links).to have_blinkbox_movies
  @movies_link = current_page.footer.links.blinkbox_movies
end

Then /^the link should point to the blinkbox movies home page$/ do
  expect(@movies_link[:href]).to include('www.blinkbox.com')
  expect(@movies_link[:target]).to eq('_blank')
  expect(@movies_link.text).to eq('blinkbox movies')
end

Given /^the blinkbox music link is present in the footer$/ do
  expect(current_page.footer.links).to have_blinkbox_music
  @music_link = current_page.footer.links.blinkbox_music
end

Then /^the link should point to the blinkbox music home page$/ do
  expect(@music_link[:href]).to include('www.blinkboxmusic.com')
  expect(@music_link[:target]).to eq('_blank')
  expect(@music_link.text).to eq('blinkbox music')
end

And /^I click on the (.+) footer link$/ do |link_name|
  click_footer_link(link_name)
end

When /^I click on the (.*) header tab$/i do |page_name|
  click_navigation_link(page_name)
end

And /^I press browser back$/ do
  go_back
end

And /^main header tabs should not be selected$/ do
  pending 'CWA-1300 - Top header is selected on the search results page' do
    assert_header_tabs_not_selected
  end
end

Then /^I should be on the Authors page$/ do
  assert_authors_page_displayed
end

And /^(.*?) section header is (.*?)$/ do |section_name, text|
  assert_section_header(section_name, text)
end

And /^I should see 'Fiction' and 'Non\-Fiction' tabs$/ do
  expect(bestsellers_page).to have_fiction_button
  expect(bestsellers_page).to have_non_fiction_button
end

And /^Grid view and List view buttons displayed$/ do
  expect(search_results_page).to have_list_view_button
  expect(search_results_page).to have_grid_view_button
end

And(/^I click on (Fiction|Non\-Fiction) tab$/) do |tab|
  tab.include?('Non') ? bestsellers_page.non_fiction_button.click : bestsellers_page.fiction_button.click
end

Then /^I should see (Fiction|Non\-Fiction) books in (grid|list) view$/ do |book_type, view|
  assert_books_displayed_with_options(book_type, view)
end

When /^I select a book to view book details$/ do
  @book_isbn = select_random_book
end

Then /^details page of the corresponding book is displayed$/ do
  expect(current_url).to include(@book_isbn)
end

And /^details of above book are displayed$/ do
  assert_book_details
end

Given /^I am on Categories page$/ do
  categories_page.load
  expect_page_displayed('Categories')
end

Given /^I am on the Book Details page (?:of a|for the same)? (paid|free) book$/ do |book_type|
  @sample ? type = "sample_for_#{book_type}_book" : type = book_type
  book_details_page.visit_for(type.downcase.to_sym)
end

And /^I try to buy the book again/ do
  click_buy_now_in_book_details_page
  sign_in_from_redirected_page
end

When /^I click on a category$/ do
  @category_name = click_on_a_category
end

Then /^Category page is displayed for the selected category$/ do
  assert_category_page_displayed(@category_name)
end

And /^the book reader is displayed$/ do
  assert_book_reader
end

And /^I am able to read the sample of corresponding book$/ do
  read_sample_book
end

When /^I select (.*?) link from the hamburger Menu$/ do|link_name|
  current_page.header.navigate_to_hamburger_menu_option(link_name)
end

Then /^I am redirected to the "([a-zA-Z ]+)" support page in a new window$/ do |support_page|
  pending('CWA-1029 - FAQ, Contact us under Support should open in new window') do
    assert_support_page(support_page)
  end
end

Then /^following FAQ links are displayed(?: on confirmation page)?:$/ do |table|
  @support_links = table
  @support_links.hashes.each do |row|
    expect(find_link(row['support links'])).to be_visible
  end
end

And /^clicking above FAQ link opens relevant support page in a new window$/ do
  @support_links.hashes.each do |row|
    click_link(row['support links'])
    assert_support_page(row['support links'])
  end
end

Given /^I am on the reset password page$/  do
  reset_password_page.load
end

And /^I click on send reset link button$/  do
  reset_password_page.send_reset_link.click
end

Then /^I should see reset error message$/  do
  expect(reset_password_page).to have_reset_message_error
end

Then /^the "Download the free app" button is displayed on the order complete page$/ do
  expect(order_complete_page.download_the_free_app_button).to be_visible
end

Then /click the "(Continue shopping|Download the free app)" button on order complete page$/ do |button_name|
  click_button_on_order_complete(button_name + '_button')
end

Then /^the "Download the free app" support page opens up in a new window$/ do
  assert_support_page(@support_links.hashes['Download the free app'])
end

Then /^selected (.+) author page displayed$/ do |author_name|
  assert_author_page_displayed(author_name)
end

Then /^selected (.+) category page displayed$/ do |category_name|
  assert_category_page_displayed(category_name)
end
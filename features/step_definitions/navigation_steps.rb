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

Then /^(?:the )?([-\&\w\s]*) page is displayed$/i do |page_name|
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
  @help_link[:href].should include 'support.blinkboxbooks.com'
  @help_link[:target].should == '_blank'
  @help_link.text.should == 'Help'
end

Given /^the blinkbox movies link is present in the footer$/ do
  expect(current_page.footer.links).to have_blinkbox_movies
  @movies_link = current_page.footer.links.blinkbox_movies
end

Then /^the link should point to the blinkbox movies home page$/ do
  @movies_link[:href].should include 'www.blinkbox.com'
  @movies_link[:target].should == '_blank'
  @movies_link.text.should == 'blinkbox movies'
end

Given /^the blinkbox music link is present in the footer$/ do
  expect(current_page.footer.links).to have_blinkbox_music
  @music_link = current_page.footer.links.blinkbox_music
end

Then /^the link should point to the blinkbox music home page$/ do
  @music_link[:href].should include 'www.blinkboxmusic.com'
  @music_link[:target].should == '_blank'
  @music_link.text.should == 'blinkbox music'
end

And /^I click on the (.+) footer link$/ do |link_name|
  click_footer_link(link_name)
end

When /^I click on the (.*) header tab$/ do |page_name|
  click_navigation_link(page_name)
end

And /^I press browser back$/ do
  page.evaluate_script('window.history.back()')
end

And /^main header tabs should not be selected$/ do
  pending "CWA-1300 - Top header is selected on the search results page" do
    assert_header_tabs_not_selected
  end
end

Then /^I should be on the Authors page$/ do
  authors_page.wait_until_featured_authors_visible
  expect_page_displayed("Authors")
end

And /^footer is displayed$/ do
  current_page.should have_footer
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

And /^I should see Promotions section header as (.*?)$/ do |promo_text|
  assert_section_header('bestsellers', promo_text)
end

And /^I should see (\d+) books being displayed$/ do |books|
  expect(bestsellers_page.daily_bestsellers.books.count).to be == books.to_i
end

And(/^I click on (Fiction|Non\-Fiction) tab$/) do |tab|
  tab.include?('Non') ? bestsellers_page.non_fiction_button.click : bestsellers_page.fiction_button.click
end

Then /^I should see (Fiction|Non\-Fiction) books in (grid|list) view$/ do |book_type, view|
  expect(search_results_page.current_view).to eq(view.to_sym)
  expect(bestsellers_page.selected_tab).to eq(book_type.gsub('-', '_').downcase.to_sym)
end

When /^I select a book to view book details$/ do
  book = search_results_page.books.random_purchasable_book
  @book_href = book.book_details_url
  book.click_view_details
end

Then /^details page of the corresponding book is displayed$/ do
  (current_url.include?(@book_href)).should == true
end

And /^details of above book are displayed$/ do
  assert_book_details
end

Given /^I am on Categories page$/ do
  categories_page.load
  expect_page_displayed('Categories')
end

When /^I click on a category$/ do
  @category_name = click_on_a_category
end

Then /^Category page is displayed for the selected category$/ do
  category_page.category_name.text.should include(@category_name)
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
  pending("CWA-1029 - FAQ, Contact us under Support should open in new window") do
    assert_support_page(support_page)
  end
end

Then /^following FAQ links are displayed(?: on confirmation page)?:$/ do |table|
  @support_links = table
  @support_links.hashes.each do |row|
    find_link(row['support links']).should be_visible
  end
end

And /^clicking above FAQ link opens relevant support page in a new window$/ do
  @support_links.hashes.each do |row|
    click_link(row['support links'])
    assert_support_page(row['support links'])
  end
end

Given /^I am on reset password page$/  do
  reset_password_page.load
end

Then /^the "Download the free app" button is displayed on the order complete page$/ do
  order_complete_page.download_the_free_app_button.should be_visible
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
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
  expect(@help_link[:href]).to include('support.blinkboxbooks.com')
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

When /^I click on the (.*) header tab$/ do |page_name|
  click_navigation_link(page_name)
end

And /^I press browser back$/ do
  page.evaluate_script('window.history.back()')
end

And /^main header tabs should not be selected$/ do
  pending "CWA-1300 - Top header is selected on the search results page" do
    within("#main-navigation") do
      tabs = page.all('li').to_a
      expect(tabs.all?{ |li| li[:class].include?("current") }).to be true, "One or more header tabs were selected: #{tabs}"
    end
  end
end

Then /^I should be on the Authors page$/ do
  authors_page.wait_until_featured_authors_visible
  expect_page_displayed("Authors")
end

And /^footer is displayed$/ do
  expect(current_page).to have_footer
end

And /^(.*?) section header is (.*?)$/ do |section_name, text|
  assert_section_header(section_name, text)
end

And /^I should see 'Fiction' and 'Non\-Fiction' tabs$/ do
  expect(bestsellers_page).to have_fiction_button
  expect(bestsellers_page).to have_non_fiction_button
end

And /^Grid view and List view buttons displayed$/ do
  expect(find('.list-view')).to be_visible
  expect(find('.list-view')).to be_visible
end

And /^I should see Promotions section header as (.*?)$/ do |promo_text|
  within('[data-id="399"]') do
    expect(page).to have_content(promo_text)
  end
end

And /^I should see (\d+) books being displayed$/ do |books|
  within('[data-title="All time best selling books"]') do
    expect(all('li').count).to eq(books.to_i)
  end
end

And(/^I click on (Fiction|Non\-Fiction) tab$/) do |tab|
  within('.tabbed') do
    find("a", :text =>"#{tab}").click
  end
end

Then /^I should see (Fiction|Non\-Fiction) books in (grid|list) view$/ do |book_type, view|
  case view
    when 'grid'
      expect(find('.grid-view')[:class]).to include('active')
      within('[data-test="bestsellers-container"]') do
        expect(find('.selected').text).to eq(book_type)
      end
    when 'list'
      expect(find('.list-view')[:class]).to include('active')
      within('[data-test="bestsellers-container"]') do
        expect(find('.selected').text).to eq(book_type)
      end
  end
end

Given /^I am on crime and thriller category page$/ do
  visit('#!/category/crime-and-thriller/')
  expect(current_path).to eq('#!/category/crime-and-thriller/')
  expect(find('[data-test="category-title"]').text).to eq('All books in Crime and Thriller')
  expect(find('[data-test="categoryid-109"]')).to be_visible
  find('[data-test="list-button"]').click
end

When /^I select a book to view book details$/ do
  book = search_results_page.books.random_purchasable_book
  @book_href = book.book_details_url
  book.click_view_details
end

Then /^details page of the corresponding book is displayed$/ do
  expect(current_url).to include(@book_href)
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
  expect(category_page.category_name.text).to include(@category_name)
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
    expect(find_link(row['support links'])).to be_visible
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
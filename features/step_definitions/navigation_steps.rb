Given /^I am on the home page/ do
  home_page.load unless home_page.displayed?
end

##############################################################
# testing header
##############################################################

When /^I click on the website logo$/ do
  #find('[data-test="logo-link"]').click
  find('div#logo').first('a').click
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
  @help_link = find('[data-test="bottom-footer-container"]').find('[data-test="footer-help-link"]')
  @help_link.visible?.should == true
end

Then /^the link should point to the blinkbox books help home page$/ do
  @help_link[:href].should include 'support.blinkboxbooks.com'
  @help_link[:target].should == '_blank'
  @help_link.text.should == 'Help'
end

Given /^the blinkbox movies link is present in the footer$/ do
  @movies_link = find('[data-test="bottom-footer-container"]').find('[data-test="footer-movies-link"]')
  @movies_link.visible?
end

Then /^the link should point to the blinkbox movies home page$/ do
  @movies_link[:href].should include 'www.blinkbox.com'
  @movies_link[:target].should == '_blank'
  @movies_link.text.should == 'blinkbox movies'
end

Given /^the blinkbox music link is present in the footer$/ do
  @music_link = find('[data-test="bottom-footer-container"]').find('[data-test="footer-music-link"]')
  @music_link.visible?
end

Then /^the link should point to the blinkbox music home page$/ do
  @music_link[:href].should include 'www.blinkboxmusic.com'
  @music_link[:target].should == '_blank'
  @music_link.text.should == 'blinkbox music'
end

And /^I click on the (.*) link$/ do |page_name|
  click_link_or_button(get_element_id_for(page_name))
end

When /^I click on the (.*) header tab$/ do |page_name|
  current_page.header.main_page_navigation(page_name)
end

And /^I press browser back$/ do
  page.evaluate_script('window.history.back()')
end

And /^main header tabs should not be selected$/ do
  within("#main-navigation") do
    page.all('li').to_a.each do |li|
      ((li[:class]).include?("current")).should == false
    end
  end
end

Then /^I should be on the Authors page$/ do
  Capybara.using_wait_time 15 do
    current_page.has_selector?("#featured_authors")
  end
  expect_page_displayed("Authors")
end

And /^footer is displayed$/ do
  find('[data-test="bottom-footer-container"]').visible?
end

And /^(.*?) header is (.*?)$/ do |section_name, text|
  assert_container(get_element_id_for(section_name))
  assert_section_header(get_element_id_for(section_name), text)
end

And /^I should see 'Fiction' and 'Non\-Fiction' tabs$/ do
  within('.tabbed') do
    page.should have_selector("a", :text => "Fiction")
    page.should have_selector("a", :text => "Non-Fiction")
  end
end

And /^Grid view and List view buttons displayed$/ do
  page.find('.list-view').should be_visible
  page.find('.grid-view').should be_visible

end

And /^I should see Promotions section header as (.*?)$/ do |promo_text|
  within('[data-id="399"]') do
    page.should have_content(promo_text)
  end
end

And /^I should see (\d+) books being displayed$/ do |books|
  within('[data-title="All time best selling books"]') do
    page.all('li').count.should == books.to_i
  end
end

And(/^I click on (Fiction|Non\-Fiction) tab$/) do |tab|
  within('.tabbed') do
    find("a", :text =>"#{tab}").click
  end
end

Then /^I should see (Fiction|Non\-Fiction) books in (gird|list) view$/ do |book_type, view|
  case view
    when 'grid'
      (find('.grid-view')[:class]).should include('active')
      within('[data-test="bestsellers-container"]') do
        find('.selected').text.should == book_type
      end
    when 'list'
      (find('.list-view')[:class]).should include('active')
      within('[data-test="bestsellers-container"]') do
        find('.selected').text.should == book_type
      end
  end
end

Given /^I am on crime and thriller category page$/ do
  visit('#!/category/crime-and-thriller/')
  current_path.should.eql?('#!/category/crime-and-thriller/') == true
  find('[data-test="category-title"]').text.eql?('All books in Crime and Thriller').should == true
  (find('[data-test="categoryid-109"]').visible?).should == true
  find('[data-test="list-button"]').click
end

When /^I select a book to view book details$/ do
  book = page.first('[class="book"]').find('[data-test="book-title-cover"]')
  @book_href = book[:href]
  book.click
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

When /^I select (.*?) link from (Your account|Shop|Support) under main Menu$/ do|link_name,sub_menu|
  current_page.header.navigate_to_main_menu_option(sub_menu, link_name)
end

Then /^following FAQ links are displayed( on confirmation page)?:$/ do |table|
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

Then /^the "([a-zA-Z ]+)" button is displayed on the confirmation page$/ do |button_name|
  button = button_name.downcase.gsub(' ', '_') + '_button'
  order_complete_page.send(button).should be_visible
end

Then /^click the "([a-zA-Z ]+)" button$/ do |button_name|
  click_button(button_name)
end

Then /^the "([a-zA-Z ]+)" support page opens up in a new window$/ do |page_name|
  assert_support_page(@support_links.hashes[page_name])
end
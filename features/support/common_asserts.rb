require 'capybara/dsl'
require 'capybara/rspec/matchers'
require 'capybara/selenium/node'

module AssertNavigation

  def assert_page(page_name)
    page = page_model(page_name)
    #unless page.displayed?
    #  raise RSpec::Expectations::ExpectationNotMetError, "Page verification failed\n   Expected page: '#{page_name}' with url_matcher #{page.url_matcher}\n   Current url: #{current_url}"
    #end
    page.wait_until_displayed
  rescue PageModelHelpers::TimeOutWaitingForPageToAppear => e
    raise RSpec::Expectations::ExpectationNotMetError, "Page verification failed\n   Expected page: '#{page_name}' with url_matcher #{page.url_matcher}\n   Current url: #{current_url}\nTimeOutWaitingForPageToAppear: #{e.message}"
  end
  alias :expect_page_displayed :assert_page

  def is_category_displayed category_id
    category_displayed=false
    within('[data-test="all-categories-list"]') do
      page.all('li').to_a.each do |li|
        begin
          if ((li.find('[data-category="category"]')['data-test']).include?(category_id) == true)
            category_displayed = true;
          end
        rescue TypeError => e
          e.message
          category_displayed = false;
        end
      end
    end
    return category_displayed
  end

  def find_category category_id
    within('[data-test="all-categories-list"]') do
      page.all('li').to_a.each do |li|
        if (li.find('[data-category="category"]')['data-test']).include?(category_id) == true
          return li.find('[data-category="category"]')['data-test'];
        end
      end
    end

  end

  def assert_main_footer_displayed
    find('[data-test="footer-container"]').should be_visible
  end

  def assert_footer_section(section)
    case section
      when 'Connect with us'
        find('[data-test="footer-connect-with-us-container"]').should be_visible
      when 'New releases'
        find('[data-test="footer-new-releases-container"]').should be_visible
      when 'Top authors in crime'
        find('[data-test="footer-top-authors-in-crime-container"]').should be_visible
      when 'Top authors'
        find('[data-test="footer-top-authors-container"]').should be_visible
    end
  end

  def assert_social_media_links
    within("[data-test='#{get_element_id_for("Connect with us container")}']") do
      find("[data-test='#{get_element_id_for("Facebook")}']").should be_visible
      find("[data-test='#{get_element_id_for("Twitter")}']").should be_visible
      find("[data-test='#{get_element_id_for("Pintrest")}']").should be_visible
    end
  end

  def assert_section_header(section_id, text)
    within("[data-test='#{section_id}']") do
      page.text.should include(text)
    end
  end

  def assert_container (section_id)
    page.find("[data-test='#{section_id}']").should be_visible
  end

  def assert_book_details
    find('[class="book-data"]').should be_visible
    within('.left-column') do
      find('[id="cover"]').should be_visible
      find('[class="details"]').should be_visible
      find('[id="description"]').should be_visible
    end
    assert_book_reader
  end

  def assert_book_reader
    within('.right-column') do
      find('[id="individual-book"]').should be_visible
    end
  end

  def assert_order_complete
    page.should have_selector('#order-complete')
  end

end

module AssertSearch
  def assert_search_results(search_word)
    expect_page_displayed("Search Results")
    search_results_page.should have_content("You searched for")
    search_results_page.searched_term.should have_content(search_word)
    search_results_page.should have_books
    search_results_page.books.count.should >= 1
  end

  def assert_author_name author_name
    selector = 'li.grid-5:nth-child(1)'
    ((find_a_text selector, 'author').downcase).should == (author_name).downcase
  end

  def assert_title book_title
    selector = 'li.grid-5:nth-child(1)'
    ((find_a_text selector, 'title').downcase).should == (book_title).downcase
  end

  def assert_unique_result
    within(".grid") do
      page.should have_css("li", :count => 1)
    end
  end

  def assert_number_of_suggestions number_of_suggestion
    within("#suggestions") do
      page.all("li").count.should >= number_of_suggestion
    end
  end

  def assert_auto_corrected_word corrected_word
    within("#suggestions") do
      i = 0
      page.all('li').to_a.each do |li|
        li.text.should == corrected_word[i]
        i += 1
      end
    end
  end

  def assert_search_word_in_suggestions search_word
    within("#suggestions") do
      page.all('li').to_a.each do |li|
        ((li.text).include?(search_word)).should == true
      end
    end
  end

  def assert_last_suggestion search_word
    within("#suggestions") do
      ((page.all('li').to_a.last).text).should == search_word
    end
  end

end

module AssertMyAccount
  def expect_account_tab_selected(tab_name)
    your_account_page.account_nav_frame.should have_account_nav_tab_selected(tab_name)
  end

  def assert_marketing_preferences(after_status)
    if (after_status)
      your_personal_details_page.marketing_prefs.should be_checked
    else
      your_personal_details_page.marketing_prefs.should_not be_checked
    end
  end

  def assert_user_greeting_message_displayed(first_name=nil)
    first_name ||= "Hi,"
    current_page.header.welcome.should have_content(first_name, :visible => true)
  end

  def assert_user_greeting_message_not_displayed()
    current_page.header.welcome.text.should be_eql("")
  end

  def assert_default_card(card)
    within('.payment_list') do
      default_card =''
      page.all('li').to_a.each do |li|
        if ((li[:class]).include?('payment_alt_row'))
          within(li) do
            within('[class="payment_card_details_container"]') do
              default_card = find('[class="payment_name ng-binding"]').text
              card.should eql(default_card)
            end
          end
          break
        end
      end
    end
  end

  def assert_book_order_and_payment_history(book_title)
    within(your_order_and_payment_history_page.ordered_books) do
      your_account_page.wait_until_spinner_invisible
      within(order_and_payment_history_page.book_list) do
        page.text should match /#{book_title}/i
      end
    end
  end

  def assert_payment_card_saved(card_count, name_on_card, card_type)
    your_account_page.wait_until_spinner_invisible
    within(your_payments_page.saved_cards_container) do
      your_payments_page.should have_saved_cards_list :count => card_count
      page.text.downcase.should include name_on_card.downcase
      page.text.downcase.should include card_type.downcase
    end
  end

  def assert_cookie_value(cookie, value)
    actual = Capybara.current_session.driver.browser.manage.cookie_named(cookie)
    if value.nil?
      actual.should be_nil
    else
      actual.should == value
    end
  end

end

World(AssertNavigation)
World(AssertSearch)
World(AssertMyAccount)










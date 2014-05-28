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

  def assert_section_header(section_id, text)
    case section_id.downcase
      when 'bestsellers'
        bestsellers_page.section_title.should include(text)
      when 'new releases'
        new_releases_page.section_title.should include(text)
      when 'free ebooks'
        free_ebooks_page.section_title.should include(text)
      when 'bestselling authors'
        authors_page.section_title.should include(text)
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
    expect(book_details_page).to have_reader
  end

  def assert_order_complete
    expect(order_complete_page).to have_order_complete_message
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
    current_page.search_form.suggestions.size.should >= number_of_suggestion
  end

  def assert_auto_corrected_word corrected_word
    current_page.search_form.suggestions.should_not be_empty
    current_page.search_form.suggestions.each do |suggestion|
      corrected_word.each do |word|
        suggestion.text.should include(word)
      end
    end
  end

  def assert_search_word_in_suggestions corrected_word
    current_page.search_form.suggestions.each { |suggestion| suggestion.text.should include(corrected_word) }
  end

  def assert_last_suggestion search_word
    within("#suggestions") do
      ((page.all('li').to_a.last).text).should == search_word
    end
  end

end

World(AssertNavigation)
World(AssertSearch)

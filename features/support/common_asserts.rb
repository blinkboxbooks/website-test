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

  def assert_message_displayed(message_text)
    expect(current_page).to have_content(message_text, :visible => true)
  end

  def assert_main_footer_displayed
    expect(find('[data-test="footer-container"]')).to be_visible
  end

  def assert_footer_section(section)
    case section
      when 'Connect with us'
        expect(find('[data-test="footer-connect-with-us-container"]')).to be_visible
      when 'New releases'
        expect(find('[data-test="footer-new-releases-container"]')).to be_visible
      when 'Top authors in crime'
        expect(find('[data-test="footer-top-authors-in-crime-container"]')).to be_visible
      when 'Top authors'
        expect(find('[data-test="footer-top-authors-container"]')).to be_visible
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

  def assert_container(section_id)
    expect(page.find("[data-test='#{section_id}']")).to be_visible
  end

  def assert_book_details
    expect(book_details_page).to be_all_there
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
    expect(search_results_page).to have_content("You searched for")
    expect(search_results_page.searched_term).to have_content(search_word)
    expect(search_results_page).to have_books
    expect(search_results_page.books.count).to be >= 1
  end

  def assert_author_name author_name
    selector = 'li.grid-5:nth-child(1)'
    expect((find_a_text selector, 'author').downcase).to eq(author_name.downcase)
  end

  def assert_title book_title
    selector = 'li.grid-5:nth-child(1)'
    expect((find_a_text selector, 'title').downcase).to eq(book_title.downcase)
  end

  def assert_unique_result
    within(".grid") do
      expect(page).to have_css("li", :count => 1)
    end
  end

  def assert_number_of_suggestions number_of_suggestion
    expect(current_page.search_form.suggestions.size).to be >= number_of_suggestion
  end

  def assert_auto_corrected_word corrected_word
    expect(current_page.search_form.suggestions.count).to be > 0
    current_page.search_form.suggestions.each do |suggestion|
      corrected_word.each do |word|
        expect(suggestion.text).to include(word)
      end
    end
  end

  def assert_search_word_in_suggestions corrected_word
    suggestions = current_page.search_form.suggestions
    expect(suggestions.all? { |suggestion| suggestion.visible? && suggestion.text.include?(corrected_word) }).to be true, "Some suggestions are not visible: #{suggestions.inspect} and/or does not include corrected word: #{corrected_word}"
  end
end

World(AssertNavigation)
World(AssertSearch)

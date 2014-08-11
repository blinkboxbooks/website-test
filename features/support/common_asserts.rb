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
      else
        raise "Unknown section header: #{section_id}"
    end
  end

  def assert_book_details
    # Latest CPR (v0.2.3) needs to be rolled out, which includes id="cpr-iframe" (capybara can't locate iframe elements by other than ID!)
    # expect(book_details_page).to be_all_there
    expect(book_details_page).to have_read_offline
    expect(book_details_page).to have_buy_now
    expect(book_details_page).to have_title_element
  end

  def assert_book_reader
    pending("Latest CPR (v0.2.3) needs to be rolled out") do
      expect(book_details_page).to have_reader
    end
  end

  def assert_order_complete
    expect(order_complete_page).to have_order_complete_message
  end

end

module AssertSearch
  def assert_search_results(search_word)
    expect_page_displayed('Search Results')
    expect(search_results_page).to have_content('You searched for')
    expect(search_results_page.searched_term).to have_content(search_word)
    expect(search_results_page).to have_books
    expect(search_results_page.books.count).to be >= 1
  end

  def assert_author_name(author_name)
    expect(books_section.books.first.author.downcase).to eq(author_name.downcase)
  end

  def assert_title(book_title)
    expect(books_section.books.first.title.downcase).to eq(book_title.downcase)
  end

  def assert_unique_result
    expect(books_section.books).to have_exactly(1).items
  end

  def assert_number_of_suggestions(number_of_suggestion)
    expect(current_page.search_form.suggestions).to have_at_least(number_of_suggestion).items
  end

  def assert_auto_corrected_word(corrected_word)
    expect(current_page.search_form.suggestions.count).to be > 0
    current_page.search_form.suggestions.each do |suggestion|
      corrected_word.each do |word|
        expect(suggestion.text).to include(word)
      end
    end
  end

  def assert_search_word_in_suggestions(corrected_word)
    suggestions = current_page.search_form.suggestions
    expect(suggestions.all? { |suggestion| suggestion.visible? && suggestion.text.include?(corrected_word) }).to be_true, "Some suggestions are not visible: #{suggestions.inspect} and/or does not include corrected word: #{corrected_word}"
  end
end

World(AssertNavigation)
World(AssertSearch)
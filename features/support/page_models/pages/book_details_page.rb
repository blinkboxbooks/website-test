module PageModels
  class BookDetailsPage < PageModels::BlinkboxbooksPage
    set_url_matcher /book/
    set_url "/#!/book/{isbn}/{title}"

    element :read_offline, ".read-offline"
    element :buy_now, 'button[data-test="book-buy-button"]'
    iframe :reader, Reader, '#cpr-iframe'
    element :title_element, '#book-details h2.title', :match => :first

    def title
      wait_for_title_element
      wait_until_title_element_visible
      title_element.text
    end

    def visit_for(book_type)
      begin
        isbn = test_data('library_isbns', book_type.to_s)
      rescue => e
        raise "Cannot load book details page with unknown book type: #{book_type.to_s}\n \nTest Data Error: #{e.message}"
      end
      self.load(:isbn => isbn, :title => 'test-book')
    end

    def buy_book
      book_title = title
      buy_now.click
      book_title
    end
  end
  register_model_caller_method(BookDetailsPage)
end
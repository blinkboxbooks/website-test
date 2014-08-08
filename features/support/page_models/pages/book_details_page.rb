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
      case book_type
        when :free then self.load(:isbn => test_data('library_isbns', 'free_book'), :title => 'test-book')
        when :paid then self.load(:isbn => test_data('library_isbns', 'pay_for_book'), :title => 'test-book')
        when :free_sample then self.load(:isbn => test_data('library_isbns', 'sample_for_free_book'), :title => 'test-book')
        when :paid_sample then self.load(:isbn => test_data('library_isbns', 'sample_for_paid_book'), :title => 'test-book')
        else raise "Cannot load book details page with unknown book type: #{book_type.to_s}"
      end
    end

    def buy_book
      book_title = title
      buy_now.click
      book_title
    end
  end
  register_model_caller_method(BookDetailsPage)
end
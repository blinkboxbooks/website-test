module PageModels
  class BookDetailsPage < PageModels::BlinkboxbooksPage
    set_url_matcher /book/
    set_url "/#!/book/{isbn}/{title}"

    element :read_offline, ".read-offline"
    element :buy_now, 'button[data-test="book-buy-button"]'
    iframe :reader, Reader, '#cpr_iframe'
    element :title_element, '#book-details h1'

    def title
      title_element.text.scan(/^(.+) by/).first.first
    end

    def visit_for(book_type)
      case book_type
        when :free then self.load(:isbn => test_data('library_isbns', 'free_book'), :title => 'test-book')
        when :paid then self.load(:isbn => test_data('library_isbns', 'pay_for_book'), :title => 'test-book')
        when :free_sample then self.load(:isbn => test_data('library_isbns', 'free_sample'), :title => 'test-book')
        when :paid_sample then self.load(:isbn => test_data('library_isbns', 'pay_for_sample'), :title => 'test-book')
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
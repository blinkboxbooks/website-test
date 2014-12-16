module PageModels
  class ReaderFrame < PageModels::BlinkboxbooksPage
    element :page, '#cpr-reader'
  end
  register_model_caller_method(ReaderFrame)

  class BookDetailsPage < PageModels::BlinkboxbooksPage
    set_url_matcher /book/
    set_url '/#!/book/{isbn}/{title}'

    element :read_offline, '.read-offline'
    element :buy_now, 'button[data-test="book-buy-button"]'
    section :reader, Reader, '.right-column'
    iframe :reader_frame, ReaderFrame, '#cpr-iframe'
    element :title_element, '#book-details h2.title', :match => :first

    def title
      wait_for_title_element
      wait_until_title_element_visible
      title_element.text
    end

    def visit_for(book_type)
      self.load(:isbn => isbn_for_book_type(book_type), :title => 'test-book')
    end

    def buy_book
      book_title = title
      buy_now.click
      book_title
    end

    def reader_page_text
      reader_frame { |frame| return page.text }
    end
  end
  register_model_caller_method(BookDetailsPage)
end
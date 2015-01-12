module PageModels
  class BookResults < PageModels::BlinkboxbooksSection
    sections :books, Book, "div[book=\"book\"]"

    def invisible_books
      books.select { |book| !book.visible? }
    end

    def purchasable_books
      wait_for_books
      books.select { |book| book.purchasable? }
    end

    def free_books
      wait_for_books
      books.select { |book| book.free? }
    end

    def books_written_by(author_name)
      wait_for_books
      books.select { |book| book.author == author_name }
    end

    def books_with_title(title)
      wait_for_books
      books.select { |book| book.title =~ /#{title}/i }
    end

    def random_purchasable_book
      sample = purchasable_books.sample
      fail 'There are no purchasable books available on the current page' if sample.nil?
      sample
    end

    def random_free_book
      sample = free_books.sample
      fail 'There are no free books available on the current page' if sample.nil?
      sample
    end

    def click_buy_now_random_book
      book = random_purchasable_book
      title = book.title
      book.click_buy_now
      title
    end

    def click_buy_now_free_book
      book = random_free_book
      title = book.title
      book.click_buy_now
      title
    end

    def click_details_random_book
      book = random_purchasable_book
      title = book.title
      book.click_view_details
      title
    end

    def click_details_free_book
      book = random_free_book
      title = book.title
      book.click_view_details
      title
    end
  end
end

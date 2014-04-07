module PageModels
  class BookResults < PageModels::BlinkboxbooksSection

    sections :books, Book, "div[book=\"book\"]"

    def purchasable_books
      wait_for_books
      purchasable = books.select { |book| book.published? && !book.free? && book.price > 0.0 }
      return purchasable
    end

    def free_books
      wait_for_books
      free = books.select { |book| book.free? }
      return free
    end

    def random_purchasable_book
      purchasable_books.sample
    end

    def random_free_book
      free_books.sample
    end

    def click_buy_now_random_book
      book = random_purchasable_book
      title = book.title
      book.click_buy_now
      return title
    end

    def click_buy_now_free_book
      book = random_free_book
      title = book.title
      book.click_buy_now
      return title
    end

    def click_details_random_book
      book = random_purchasable_book
      title = book.title
      book.click_view_details
      return title
    end

    def click_details_free_book
      book = random_free_book
      title = book.title
      book.click_view_details
      return title
    end

  end
end
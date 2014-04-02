module PageModels
  class BookResults < PageModels::BlinkboxbooksSection

    sections :books, Book, "div[book=\"book\"]"

    def book_by_index(index)
      raise "Cannot find book with index #{index.to_s}" if books[index].nil?
      return books[index]
    end

    def purchasable_books
      wait_for_books
      book_list = books
      book_list.keep_if { |book| book.published? && !book.free? && book.get_book_price > 0.0 }
      return book_list
    end

    def free_books
      wait_for_books
      book_list = books
      book_list.keep_if { |book| book.free? }
      return book_list
    end

    def random_book
      rand(0...purchasable_books.count)
    end

    def random_free_book
      rand(0...free_books.count)
    end

    def random_book_price_less_than(price)
      purchasable_books.each do |book|
        if book.has_price? && book.get_book_price < price.to_f
          book_price = book.get_book_price
          book.click_buy_now
          return book_price
        end
      end
    end

    def random_book_price_more_than(price)
      purchasable_books.each do |book|
        if book.has_price? && book.get_book_price > price.to_f
          book_price = book.get_book_price
          book.click_buy_now
          return book_price
        end
      end
    end

    def click_buy_now_random_book
      book_by_index(random_book).click_buy_now
    end

    def click_buy_now_free_book
      book_by_index(random_free_book).click_buy_now
    end

    def click_details_random_book
      book_by_index(random_book).click_details_button
    end

    def click_details_free_book
      book_by_index(random_free_book).click_details_button
    end

  end
end
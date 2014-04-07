module PageModels
  module BookResultsActions

    def books_section
      search_results_page.wait_for_book_results_sections
      search_results_page.book_results_sections.first
    end

    def select_random_book_cheaper_than(price)
      books_section.purchasable_books.each do |book|
        if book.price < price.to_f
          book_price = book.price
          book.click_buy_now
          return book_price
        end
      end
    end

    def select_random_book_more_expensive_than(price)
      books_section.purchasable_books.each do |book|
        if book.price > price.to_f
          book_price = book.price
          book.click_buy_now
          return book_price
        end
      end
    end

  end
end

World(PageModels::BookResultsActions)
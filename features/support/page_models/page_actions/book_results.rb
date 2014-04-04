module PageModels
  module BookResultsActions

    def books_section
      current_page.wait_for_book_results_sections
      current_page.book_results_sections.first
    end
    
    def select_random_book_cheaper_than(price)
      books_section.purchasable_books.each do |book|
        if book.has_price? && book.price.to_f < price.to_f
          book_price = book.price
          book.click_buy_now
          return book_price
        end
      end
    end

    def select_random_book_more_expensive_than(price)
      book_results.purchasable_books.each do |book|
        if book.has_price? && book.price.to_f > price.to_f
          book_price = book.price
          book.click_buy_now
          return book_price
        end
      end
    end

  end
end

World(PageModels::BookResultsActions)
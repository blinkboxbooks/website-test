module PageModels
  module BookResultsActions

    def select_random_book_cheaper_than(price)
      search_results_page.book_results_sections.first.purchasable_books.each do |book|
        if book.has_price? && book.price.to_f < price.to_f
          book_price = book.price
          book.click_buy_now
          return book_price
        end
      end
    end

    def select_random_book_more_expensive_than(price)
      search_results_page.book_results_sections.first.purchasable_books.each do |book|
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
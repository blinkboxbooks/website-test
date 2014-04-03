module PageModels
  module DiscoverBookActions
    def search_blinkbox_books(search_word)
      puts "Searching for books with search word '#{search_word}'"
      current_page.header.wait_until_search_input_visible
      current_page.header.search_input.set search_word
      current_page.header.wait_until_search_button_visible
      current_page.header.search_button.click
      search_results_page.wait_for_books
    end

    def click_on_a_category
      @category_name = categories_page.select_category_by_index
      expect_page_displayed('Category')
      category_page.wait_until_book_results_sections_visible(10)
      return @category_name
    end

    def sort_search_results(sort_criteria)
      search_results_page.order_by.hover
      search_results_page.sort_options.each do |sort_otpion|
        sort_otpion.text.eql?(sort_criteria)
        sort_otpion.click
      end
      search_results_page.wait_until_book_results_sections_visible(10)
    end

    def select_buy_first_book_in_search_results
      search_results_page.book_results_sections.first.click_book_details_for_book(0)
    end

    def user_navigates_to_book_details(book_type)
      search_word = return_search_word_for_book_type(book_type)
      search_blinkbox_books(search_word)
      if book_type == "free"
        search_results_page.book_results_sections.first.click_details_free_book
      else
        search_results_page.book_results_sections.first.click_details_random_book
      end
    end

    def buy_sample_added_book
      visit(@book_href)
      click_buy_now_in_book_details_page
    end

    def select_book_to_buy_from_home_page
      home_page.wait_for_book_results_sections
      home_page.book_results_sections.first.click_buy_now_random_book
    end

    def select_book_to_buy_from_category_page
      current_page.header.main_page_navigation('Categories')
      click_on_a_category
      category_page.book_results_sections.first.click_buy_now_random_book
    end

    def select_book_to_buy_from_book_detials_page (book_type = 'pay for')
      book_title = user_navigates_to_book_details(book_type)
      book_details_page.buy_now.click
      return book_title
    end

    def select_book_to_buy_from (page_name, book_type)
      book_page = page_model page_name
      book_page.header.main_page_navigation page_name
      expect_page_displayed page_name
      book_page.wait_until_book_results_sections_visible(10)
      if book_type == "free"
        book_page.book_results_sections.first.click_buy_now_free_book
      else
        book_page.book_results_sections.first.click_buy_now_random_book
      end
    end

    def select_book_to_buy_from_search_results_page (book_type = 'pay for')
      search_word = return_search_word_for_book_type(book_type)
      search_blinkbox_books(search_word)
      if book_type == 'pay for'
        search_results_page.book_results_sections.first.click_buy_now_random_book
      else
        search_results_page.book_results_sections.first.click_buy_now_free_book
      end
    end

    def buy_book_by_price(condition, price)
      search_word = return_search_word_for_book_type('pay for')
      search_blinkbox_books(search_word)
      if condition.eql?('more')
        book_price = select_random_book_more_expensive_than(price)
      elsif condition.eql?('less')
        book_price = select_random_book_cheaper_than(price)
      end
      return book_price
    end

    def select_best_selling_book_to_buy_from_book_details
      bestsellers_page.load
      bestsellers_page.wait_for_book_results_sections
      book_title = bestsellers_page.book_results_sections.first.click_details_random_book
      book_details_page.buy_now.click
      return book_title
    end

    def select_free_book_to_buy_from_book_details
      search_blinkbox_books('free')
      search_results_page.book_results_sections.first.click_details_random_book
      book_title = book_details_page.buy_now.click
      return book_title
    end

  end
end
World(PageModels::DiscoverBookActions)

module PageModels
  module DiscoverBookActions
    def search_blinkbox_books(search_word, view = 'list')
      puts "Searching for books with search word '#{search_word}'"
      current_page.header.wait_until_search_input_visible
      current_page.header.search_input.set search_word
      current_page.header.wait_until_search_button_visible
      current_page.header.search_button.click
      search_results_page.wait_for_books
      switch_to_list_view if view == 'list'
    end

    def click_on_a_category
      @category_name = categories_page.select_category_by_index
      expect_page_displayed('Category')
      category_page.wait_until_book_results_sections_visible(10)
      @category_name
    end

    def select_book_to_view_details(book_type)
      search_blinkbox_books(return_search_word_for_book_type(book_type))
      book_type == :free ? books_section.click_details_free_book : books_section.click_details_random_book
    end

    def buy_sample_added_book
      book_details_page.load(:isbn => @book_isbn)
      click_buy_now_in_book_details_page
    end

    def select_book_to_buy(book_type)
      search_blinkbox_books(return_search_word_for_book_type(book_type))

      if book_type == :free
        books_section.click_buy_now_free_book
      else
        books_section.click_buy_now_random_book
      end
    end

    def select_book_to_add_as_sample(book_type, page)
      isbn = test_data('library_isbns', 'free_sample') if book_type == 'free'
      isbn = test_data('library_isbns', 'pay_for_sample') if book_type == 'paid'
      if page == :search_results
        search_blinkbox_books(isbn)
        search_results_page.book_cover.click
      else
        page_model('Book Details').load(isbn: isbn, title: 'a_book_title')
      end
      book_details_page.read_offline.click
    end

    def select_book_to_buy_on(page_name, book_type)
      if page_name =~ /Search results/i
        search_blinkbox_books(return_search_word_for_book_type(book_type))
      elsif page_name =~ /Book details/i
        page_model(page_name).load(isbn: test_data('library_isbns', book_type.downcase.gsub(' ', '_') + '_book'), title: 'a_book_title')
        book_title = book_details_page.title
        book_details_page.buy_now.click
        return book_title
      elsif page_name =~ /Category/i
        page_model(page_name).load(name: 'thriller-suspense')
      elsif current_page.header.tab(page_name).nil?
        page = page_model(page_name)
        page.load unless page.displayed?
      else
        click_navigation_link(page_name) unless page_model(page_name).displayed?
      end
      expect_page_displayed page_name

      if book_type == :free
        books_section.click_buy_now_free_book
      else
        books_section.click_buy_now_random_book
      end
    end

    def select_book_to_buy_from(page_name, book_type)
      if page_name =~ /Search results/i
        search_blinkbox_books(return_search_word_for_book_type(book_type))
      elsif page_name =~ /Book details/i
        search_blinkbox_books(return_search_word_for_book_type(book_type))
        book_type == :free ? books_section.click_details_free_book : books_section.click_details_random_book
        book_title = book_details_page.title
        book_details_page.buy_now.click
        return book_title
      elsif page_name =~ /Category/i
        click_navigation_link('categories')
        categories_page.select_category_by_index
        switch_to_list_view
      elsif current_page.header.tab(page_name).nil?
        page = page_model(page_name)
        page.load unless page.displayed?
      else
        click_navigation_link(page_name) unless page_model(page_name).displayed?
        switch_to_list_view
      end
      book_type == :free ? books_section.click_buy_now_free_book : books_section.click_buy_now_random_book
    end

    def select_book_from_grid_view(book_type)
      search_blinkbox_books(return_search_word_for_book_type(book_type), 'grid')
      if book_type == :free
        books_section.click_buy_now_free_book
      else
        books_section.click_buy_now_random_book
      end
    end

    def buy_book_by_price(condition, price)
      search_word = return_search_word_for_book_type('paid')
      search_blinkbox_books(search_word)
      if condition.eql?('more')
        select_random_book_more_expensive_than(price)
      elsif condition.eql?('less')
        select_random_book_cheaper_than(price)
      end
    end

    def select_book_by_isbn_to_buy(isbn)
      search_blinkbox_books isbn
      books_section.books[0].click_view_details
      book_details_page.wait_for_buy_now
      book_details_page.buy_now.click
    end

    def select_book_by_isbn_to_read(isbn)
      search_blinkbox_books isbn
      books_section.books[0].click_view_details
      click_read_offline
    end

    def select_random_book
      book = books_section.random_purchasable_book
      book_isbn = book.isbn
      book.click_view_details
      book_isbn
    end

  end
end
World(PageModels::DiscoverBookActions)

module Discover
  def search_blinkbox_books(search_word)
    puts "Searching for books with search word '#{search_word}'"
    page.should have_selector("#term")
    fill_in('term', :with => "#{search_word}")
    page.should have_selector("button#submit_desk")
    click_button('submit_desk')
    search_results_page.wait_for_books
  end

  def click_book_details_for_first_book_in_search_results
    within('[data-test="search-results-list"]') do
      within(first('li')) do
        @book_href= first('a')[:href]
        first('a').click
      end
    end
    return @book_href
  end

  def click_on_a_category
   find('[data-test="all-categories-list"]').should be_visible
   within('[data-test="all-categories-list"]') do
      within(first('li')) do
        within('[class="cover"]') do
          @category_name = first('a')[:href]
          first('img').click
        end
      end
   end
   return @category_name
  end

  def sort_search_results(sort_criteria)
    page.should have_selector("div.orderby")
    element = find('div.orderby')
    mouse_over(element)
    find('div.orderby').should have_selector('ul')
    within('div.orderby') do
      within(first('ul')) do
        page.all('li').to_a.each do |li|
          if (li.text.eql?(sort_criteria))
            li.click
          end
        end
      end
    end
  end

  def select_buy_first_book_in_search_results
    search_results_page.should have_books
    found = false
    search_results_page.books.each do |book|
      if book.first('button[data-test="book-buy-button"]', :visible => false)
        mouse_over(book)
        book.first('button[data-test="book-buy-button"]').click
        found = true
        break
      end
    end
    raise "Unable to find a purchasable book in the search results" unless found
  end

  def click_buy_now_best_seller_book
    click_link "Bestsellers"
    page.has_selector?('.bookList')
    within('.bookList') do
      element= first('[class="book featured"]')
      mouse_over(element)
    end
    click_button('BUY NOW')
  end

  def buy_first_book
    search_blinkbox_books('winter')
    #TODO: pending sorting bug fix, it currently sorts in the reverse direction form selected
    #sort_search_results('Price (high to low)')
    select_buy_first_book_in_search_results
    successful_new_payment(save_payment = true)
  end

  def user_selects_a_book_to_buy(search_word)
    search_blinkbox_books(search_word)
    #TODO: pending sorting bug fix, it currently sorts in the reverse direction form selected
    #sort_search_results('Price (high to low)')
    select_buy_first_book_in_search_results
  end

  def user_navigates_to_book_details(search_word)
    search_blinkbox_books(search_word)
    click_book_details_for_first_book_in_search_results
  end

  def buy_sample_added_book
    visit(@book_href)
    click_buy_now_in_book_details_page
  end

  def select_book_to_buy_from_a_page(book_type, page_name)
    book_page = page_model(page_name)
    case page_name
      when 'Home'
        book_title = book_page.book_results_sections.first.click_buy_now_for_book
      when 'Book details'
        book_title = home_page.book_results_sections.first.click_book_details_for_book
        book_page.buy_now.click
      when 'Category'
        book_page.header.main_page_navigation('Categories')
        categories_page.select_category_by_index
        expect_page_displayed(page_name)
        book_title = book_page.book_results_sections.first.click_buy_now_for_book
      when 'Search results'
        search_word = return_search_word_for_book_type(book_type)
        search_blinkbox_books(search_word)
        book_title  = book_page.book_results_sections.first.click_buy_now_for_book
      when 'Bestsellers', 'New releases', 'Free books'
        book_page.header.main_page_navigation(page_name)
        expect_page_displayed(page_name)
        book_page.wait_until_book_results_sections_visible(10)
        book_title = book_page.book_results_sections.first.click_buy_now_for_book
      else
        raise "Not handled page type #{page_name}"
    end
    return book_title
  end
end

module ManageAccount
  def click_link_from_my_account_dropdown(link_name)
    current_page.header.should be_visible
    current_page.header.navigate_to_account_option(link_name)
  end

  def edit_personal_details
    first_name = generate_random_first_name
    last_name = generate_random_last_name
    puts "Changing first name from '#{your_personal_details_page.first_name.value}' to '#{first_name}'"
    puts "Changing last name from '#{your_personal_details_page.first_name.value}' to '#{last_name}'"
    your_personal_details_page.first_name.set first_name
    your_personal_details_page.last_name.set last_name
    return first_name, last_name
  end

  def navigate_to_my_account_landing_page
    within(find('[id="username"]')) do
      first('a').click
    end
  end

  def click_on_my_account_tab(tab_name)
    within('.account_menu') do
      page.all('li').to_a.each do |li|
        if li.text.eql?(tab_name)
          li.click
        end
      end
    end
  end

  def edit_marketing_preferences
    before_status = page.has_checked_field?('newsletter')
    if (before_status)
      uncheck('newsletter')
    else
      check('newsletter')
    end
    after_status = page.has_checked_field?('newsletter')
    return after_status
  end

  def set_card_default
    within('.payment_list') do
      page.all('li').to_a.each do |li|
        if not ((li[:class]).include?('payment_alt_row'))
          within(li) do
            within('[class="payment_default"]') do
              find('label').click
            end
            within('[class="payment_card_details_container"]') do
              @default_card = find('[class="payment_name ng-binding"]').text
            end
          end
          break
        end
      end
    end
    click_button('Update default card')
    return @default_card
  end

end

module CommonActions
  def app_version_info
    current_page.footer.version_info
  end
end

World(Discover)
World(ManageAccount)
World(CommonActions)






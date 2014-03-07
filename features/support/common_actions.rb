module Discover
  def search_blinkbox_books(search_word)
    puts "Searching for books with search word '#{search_word}'"
    page.should have_selector("#term")
    fill_in('term', :with => "#{search_word}")
    page.should have_selector("button#submit_desk")
    click_button('submit_desk')
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
    search_results_page.book_results_sections.first.click_buy_now_for_book(0)
  end

  def user_navigates_to_book_details(book_type)
    search_word = return_search_word_for_book_type(book_type)
    search_blinkbox_books(search_word)
    search_results_page.book_results_sections.first.click_book_details_for_book
  end

  def buy_sample_added_book
    visit(@book_href)
    click_buy_now_in_book_details_page
  end

  def select_book_to_buy_from_home_page
    home_page.book_results_sections.first.click_buy_now_for_book
  end

  def select_book_to_buy_from_category_page
    current_page.header.main_page_navigation('Categories')
    click_on_a_category
    category_page.book_results_sections.first.click_buy_now_for_book
  end

  def select_book_to_buy_from_book_detials_page (book_type = 'pay for')
    book_title = user_navigates_to_book_details(book_type)
    book_details_page.buy_now.click
    return book_title
  end

  def select_book_to_buy_from (page_name)
    book_page = page_model page_name
    book_page.header.main_page_navigation page_name
    expect_page_displayed page_name
    book_page.wait_until_book_results_sections_visible(10)
    book_page.book_results_sections.first.click_buy_now_for_book
  end

  def select_book_to_buy_from_search_results_page (book_type = 'pay for')
    search_word = return_search_word_for_book_type(book_type)
    search_blinkbox_books(search_word)
    search_results_page.book_results_sections.first.click_buy_now_for_book
  end

  def buy_book_by_price(condition, price)
    search_word = return_search_word_for_book_type('pay for')
    search_blinkbox_books(search_word)
    if condition.eql?('more')
      book_price = search_results_page.book_results_sections.first.buy_now_book_price_more_than price
    elsif condition.eql?('less')
      book_price = search_results_page.book_results_sections.first.buy_now_book_price_less_than price
    end
    return book_price
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






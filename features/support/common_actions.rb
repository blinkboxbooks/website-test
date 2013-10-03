module Discover
  def search_blinkbox_books(search_word)
    fill_in('term', :with => "#{search_word}")
    click_button('submit_desk')
  end

  def click_book_details
    within('[data-test="search-results-list"]') do
      within(first('li')) do
        @book_href= first('a')[:href]
        first('a').click
      end
    end
    return @book_href
  end

  def click_on_a_category
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
    element = find('.orderby')
    mouse_over(element)
    within('.orderby') do
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
    within('.grid') do
      element= first('[class="book"]')
      mouse_over(element)
      click_button('BUY NOW')
    end
  end

end


module RegisterAndSignIn
  def click_register_button
    click_button('Register')
  end

  def enter_personal_details
    email_address = generate_random_email_address
    first_name = generate_random_first_name
    last_name = generate_random_last_name
    fill_form_element('email', email_address)
    fill_form_element('first_name', first_name)
    fill_form_element('last_name', last_name)
    return email_address, first_name, last_name
  end

  def choose_a_valid_password(value)
    fill_form_element('password', value)
    fill_form_element('repassword', value)
  end

  def update_password(current_password, new_password)
    fill_form_element('currentpassword', current_password)
    fill_form_element('password', new_password)
    fill_form_element('repassword', new_password)
  end

  def enter_valid_sign_in_details (email_address, password)
    fill_form_element('email', email_address)
    fill_form_element('password', password)
  end

  def click_sign_in_button
    click_button('Sign in')
  end

  def click_sign_in_link
    find('[data-test="header-sign-in-link"]').click
  end

  def accept_terms_and_conditions
    check('termsconditions')
  end

  def submit_registration_details
    find('[class="yellow_button ng-binding"]').click
  end

  def register_new_user
    enter_personal_details
    choose_a_valid_password('test1234')
    accept_terms_and_conditions
    submit_registration_details
  end

  def sign_in(email_address, password)
    click_sign_in_link
    enter_valid_sign_in_details(email_address, password)
    click_sign_in_button
  end

end

module Buy
  def enter_card_number(number)
    fill_form_element('number_card', number)
  end

  def select_expiry_date (month, year)
    select_value('card_dates_month', month)
    select_value('card_dates_year', year)
  end

  def enter_cvv(card_type)
    cvv='123'
    if (card_type.eql?('American Express'))
      cvv='1234'
    end
    fill_form_element('number_cvv', cvv)
  end

  def enter_name_on_card(name)
    fill_form_element('card_name', name)
  end

  def enter_address_line_one(line_one)
    fill_form_element('address_one', line_one)
  end

  def enter_address_line_two(line_two)
    fill_form_element('address_two', line_two)
  end

  def enter_town_or_city(town_or_city)
    fill_form_element('address_three', town_or_city)
  end

  def enter_post_code(post_code)
    fill_form_element('address_four', post_code)
  end


  def enter_new_payment_details(card_type)
    enter_card_number(get_card_number_by_type(card_type))
    select_expiry_date('12', '2023')
    enter_name_on_card('jamie jones')
    enter_cvv(card_type)
  end

  def enter_billing_details
    enter_address_line_one('my address line one')
    enter_address_line_two('my address line two')
    enter_town_or_city('My town')
    enter_post_code('WC18AQ')
  end

  def click_confirm_and_pay
    find('[class="yellow_button ng-binding"]')
  end

  def save_card_details()
    check('save_details')
  end

  def click_buy_now_best_seller_book
    click_link_or_button(get_element_id_for('Best sellers'))
    within('.bookList') do
      element= first('[class="book featured"]')
      mouse_over(element)
    end
    click_button('BUY NOW')
  end

  def pay_with_saved_card
    if (page.has_text?(:visible, 'Your saved card details'))
      click_button('Confirm & pay')
    end
  end

  def buy_first_book
    search_blinkbox_books('winter')
    sort_search_results('Price (high to low)')
    select_buy_first_book_in_search_results
    enter_new_payment_details('VISA')
    enter_billing_details
    click_confirm_and_pay
  end

  def returning_user_selects_a_book
    search_blinkbox_books('summer')
    sort_search_results('Price (high to low)')
    select_buy_first_book_in_search_results
  end
end


module ManageAccount
  def click_link_from_my_account_dropdown(link)
    element = find('[id="options"]')
    page.driver.browser.action.move_to(element.native).perform
    find("[title='#{link}']").click
  end

  def edit_personal_details
    first_name = generate_random_first_name
    last_name = generate_random_last_name
    fill_form_element('first_name', first_name)
    fill_form_element('last_name', last_name)
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

end

World(Discover)
World(RegisterAndSignIn)
World(Buy)
World(ManageAccount)






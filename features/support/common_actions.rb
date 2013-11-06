module Discover
  def search_blinkbox_books(search_word)
    puts "Searching for books with search word '#{search_word}'"
    page.should have_selector("#term")
    fill_in('term', :with => "#{search_word}")
    page.should have_selector("button#submit_desk")
    click_button('submit_desk')
    search_results_page.wait_for_results
    #page.has_selector?("div.orderby") || page.has_selector?("div.noResults")
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
    search_results_page.should have_results
    element = search_results_page.results.first
    mouse_over(element)
    element.find('button[data-test="book-buy-button"]').click
  end

end


module RegisterAndSignIn
  def click_register_button
    sign_in_page.register_button.click
  end

  def enter_personal_details
    expect_page_displayed("Register")

    @email_address = generate_random_email_address
    first_name = generate_random_first_name
    last_name = generate_random_last_name

    register_page.fill_in_personal_details(first_name, last_name, @email_address)
    return @email_address, first_name, last_name
  end

  def choose_a_valid_password(value)
    register_page.fill_in_password(value)
  end

  def update_password(current_password, new_password)
    fill_form_element('currentPassword', current_password)
    fill_form_element('password', new_password)
    fill_form_element('repassword', new_password)
  end

  def enter_valid_sign_in_details(email_address, password)
    fill_form_element('email', email_address)
    fill_form_element('password', password)
  end

  def click_sign_in_button
    page.should have_selector("button", :text => "Sign in")
    click_button('Sign in')
  end

  def submit_sign_in_details(email_address, password)
    sign_in_page.sign_in_form.submit(email_address, password)
  end

  def navigate_to_sign_in_form
    click_link_from_my_account_dropdown('Sign in')
  end

  def navigate_to_register_form
    navigate_to_sign_in_form
    click_button('Register')
  end

  def accept_terms_and_conditions
    register_page.terms_and_conditions.set(true)
  end

  def submit_registration_details
    register_page.register_button.click
    #registration_success_page.wait_for_welcome_label || register_page.wait_for_errors_section
  end

  def register_new_user
    @password = 'test1234'
    enter_personal_details
    choose_a_valid_password(@password)
    accept_terms_and_conditions
    submit_registration_details
  end

  def sign_in(email_address=@email_address,password=@password)
    email_address ||= 'bkm1@aa.com'
    password ||= 'test1234'
    navigate_to_sign_in_form
    submit_sign_in_details(email_address, password)
    assert_user_greeting_message_displayed(@first_name)
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
    click_button('Confirm & pay')
    page.has_selector?('#order-complete')
    page.should have_content('Welcome to blinkbox books!')
  end

  def save_card_details()
    check('save_details')
  end

  def click_buy_now_best_seller_book
    click_link "Best sellers"
    #click_link_or_button(get_element_id_for('Best sellers'))
    within('.bookList') do
      element= first('[class="book featured"]')
      mouse_over(element)
    end
    click_button('BUY NOW')
  end

  def pay_with_saved_card
    #TODO: add step to click radio button
    if (page.has_text?(:visible, 'Your saved card details'))
      click_button('Confirm & pay')
      page.has_selector?('#order-complete')
      page.has_content?('Thanks for your order!')
    end
  end

  def pay_with_new_card(card_type)
    enter_new_payment_details(card_type)
    click_button('Confirm & pay')
    page.has_selector?('#order-complete')
    page.has_content?('Thanks for your order!')
  end

  def buy_first_book
    search_blinkbox_books('winter')
    #TODO: pending sorting bug fix, it currently sorts in the reverse direction form selected
    #sort_search_results('Price (high to low)')
    select_buy_first_book_in_search_results
    enter_billing_details
    pay_with_new_card('VISA')
  end

  def returning_user_selects_a_book
    search_blinkbox_books('summer')
    #TODO: pending sorting bug fix, it currently sorts in the reverse direction form selected
    #sort_search_results('Price (high to low)')
    select_buy_first_book_in_search_results
  end

end


module ManageAccount
  def click_link_from_my_account_dropdown(link_name)
    current_page.header.navigate_to_account_option(link_name)
  end

  def edit_personal_details
    first_name = generate_random_first_name
    last_name = generate_random_last_name
    puts "Changing first name from '#{find('input#first_name').value}' to '#{first_name}'"
    puts "Changing last name from '#{find('input#last_name').value}' to '#{last_name}'"
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
World(RegisterAndSignIn)
World(Buy)
World(ManageAccount)
World(CommonActions)






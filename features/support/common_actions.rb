module Discover
  def search_blinkbox_books(search_word)
    fill_in('term', :with => "#{search_word}")
    click_button('submit_desk')
  end

  def click_book_details
    within('[class="expandable itemsets"]') do
      within(first('.book')) do
        @book_href= find('[data-test="book-title-cover"]')[:href]
        find('[data-test="book-title-cover"]').click
      end
    end
  end
end


module RegisterAndSignIn
  def click_register_button
    find('[class="blue_button ng-binding"]').click
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

  def enter_valid_sign_in_details (email_address, password)
    fill_form_element('email', email_address)
    fill_form_element('password', password)
  end

  def click_sign_in_button
    find('[class="yellow_button float-right ng-binding"]').click
  rescue
    find("[data-test='#{get_element_id_for("Sign in")}']").click

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
    click_sign_in_button
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

  def click_buy_now_in_book_details
    #TODO: come up with a proper sync instead of always sleep for 2 seconds
    find('[class="details"]').should be_visible
    begin
      sleep(2)
    end until (find('[data-test="book-buy-button"]', :visible => true).visible?)
    click_button('BUY NOW')
  end
end


module ManageAccount
  def click_link_from_my_account_dropdown(link)
    page.execute_script("document.getElementById('options').getElementsByTagName('ul')[0].style.display='inline-block'")
    find("[title='#{link}']").click
    page.execute_script("document.getElementById('options').getElementsByTagName('ul')[0].style.display='none'")
  end

  def edit_personal_details
    first_name = generate_random_first_name
    last_name = generate_random_last_name
    fill_form_element('first_name', first_name)
    fill_form_element('last_name', last_name)
    return first_name, last_name
  end
end


World(Discover)
World(RegisterAndSignIn)
World(Buy)
World(ManageAccount)






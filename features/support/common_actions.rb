def search_blinkbox_books(search_word)
  fill_in('term', :with => "#{search_word}")
  click_button('submit_desk')
end

def enter_personal_details
  email_address = generate_random_email_address
  first_name = generate_random_first_name
  fill_form_element('email', email_address)
  fill_form_element('first_name', first_name)
  fill_form_element('last_name', 'cucumber')
end

def choose_a_valid_password(value)
  fill_form_element('password', value)
  fill_form_element('repassword', value)
end

def enter_valid_sign_in_details (email_address,password)
  fill_form_element('email', email_address)
  fill_form_element('password', password)
end

def fill_form_element (element, value)
  fill_in("#{element}", :with => "#{value}")
end






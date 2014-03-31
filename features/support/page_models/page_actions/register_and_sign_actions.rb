module PageModels
  module RegisterAndSigninActions
    def click_register_button
      sign_in_page.wait_for_register_button
      sign_in_page.register_button.click
    end

    def enter_sign_in_details(email_address, password)
      fill_form_element('email', email_address)
      sign_in_page.show_password.set(true)
      fill_form_element('password', password)
    end

    def submit_sign_in_details(email_address, password)
      sign_in_page.sign_in_form.submit(email_address, password)
    end

    def enter_personal_details(email_address=@email_address)
      expect_page_displayed("Register")
      email_address ||= generate_random_email_address
      first_name = generate_random_first_name
      last_name = generate_random_last_name
      register_page.fill_in_personal_details(first_name, last_name, email_address)
      return email_address, first_name, last_name
    end

    def enter_password(value)
      register_page.fill_in_password(value)
    end

    def update_password(current_password, new_password, re_enter_password = new_password)
      change_password_page.current_password.set current_password
      change_password_page.enter_new_password.set new_password
      change_password_page.re_enter_new_password.set re_enter_password
    end

    def click_sign_in_button
      sign_in_page.sign_in_form.click_sign_in_button
    end

    def navigate_to_sign_in_form
      click_link_from_my_account_dropdown('Sign in')
    end

    def navigate_to_register_form
      navigate_to_sign_in_form
      click_button('Register')
    end

    def accept_terms_and_conditions(accept_terms)
      register_page.terms_and_conditions.set(accept_terms)
    end

    def submit_registration_details
      register_page.register_button.click
      puts "Email address used for user registration: #{@email_address}, #{@first_name} #{@last_name}"
      #registration_success_page.wait_for_welcome_label || register_page.wait_for_errors_section
    end

    def register_new_user(provide_clubcard = 'without', clubcard_number = '')
      @password = test_data("passwords", "valid_password")
      @email_address, @first_name, @last_name = enter_personal_details
      enter_password(@password)
      register_page.fill_in_club_card(clubcard_number) if provide_clubcard.eql?('with')
      accept_terms_and_conditions(true)
      submit_registration_details
      puts "Email address used for user registration: #{@email_address}, #{@first_name} #{@last_name}"
      return @password, @email_address, @first_name, @last_name
    end

    def sign_in(email_address=@email_address, password=@password)
      email_address ||= test_data("emails", "user_with_devices")
      password ||= test_data("passwords", "valid_password")
      if logged_in_session?
        raise "User is already signed in, which is not expected, please check your flow"
      else
        navigate_to_sign_in_form
        submit_sign_in_details(email_address, password)
      end
      puts "Email address used for user sign-in: #{email_address}"
    end

    def set_email_and_password(email_address, password)
      @email_address = email_address
      @password = password
    end

    def cancel_registration
      register_page.cancel_registration.click
    end

    def confirm_cancel_registration
      page.should have_selector('#delete-card')
      register_page.confirm_cancel_registration.click
    end

    def sign_out_and_start_new_session
      your_account_page.sign_out_button.click
      visit('/')
    end

    def sign_in_from_redirected_page
      sign_in_page.sign_in_form.submit(@email_address, @password)
    end
  end
end
World(PageModels::RegisterAndSigninActions)



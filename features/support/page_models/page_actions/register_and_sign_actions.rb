module PageModels
  module RegisterAndSigninActions
    def click_register_button
      sign_in_page.register_button.click
    end

    def enter_valid_sign_in_details(email_address, password)
      fill_form_element('email', email_address)
      fill_form_element('password', password)
    end

    def submit_sign_in_details(email_address, password)
      sign_in_page.sign_in_form.submit(email_address, password)
    end

    def enter_personal_details
      expect_page_displayed("Register")

      email_address = generate_random_email_address
      first_name = generate_random_first_name
      last_name = generate_random_last_name

      register_page.fill_in_personal_details(first_name, last_name, email_address)
      return email_address, first_name, last_name
    end

    def choose_a_valid_password(value)
      register_page.fill_in_password(value)
    end

    def update_password(current_password, new_password)
      fill_form_element('currentPassword', current_password)
      fill_form_element('password', new_password)
      fill_form_element('repassword', new_password)
    end

    def click_sign_in_button
      page.should have_selector("button", :text => "Sign in")
      click_button('Sign in')
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
      @email_address, @first_name, @last_name = enter_personal_details
      choose_a_valid_password(@password)
      accept_terms_and_conditions
      submit_registration_details
      puts "Email address used for user registration: #{@email_address}"
    end

    def sign_in(email_address=@email_address, password=@password)
      email_address ||= 'bkm1@aa.com'
      password ||= 'test1234'
      if logged_in_session?
        raise "User is already signed in, which is not expected, please check your flow"
      else
        navigate_to_sign_in_form
        submit_sign_in_details(email_address, password)
        assert_user_greeting_message_displayed(@first_name)
      end
      puts "Email address used for user sign-in: #{email_address}"
    end

  end
end
World(PageModels::RegisterAndSigninActions)



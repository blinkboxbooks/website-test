module PageModels
  class GiftingSignInForm < PageModels::BlinkboxbooksSection
    element :email, '[data-test="email-address"]'
    element :password, '[data-test="password"]'
    element :sign_in_button, '[data-test="signin-button"]'
    element :error_element, '#error_signin'

    def submit(email, password)
      wait_for_sign_in_button
      self.email.set email
      self.password.set password
      self.sign_in_button.click
    end

    def displayed?
      self.email.visible? && self.password.visible? && self.sign_in_button.visible?
    end

    def error_message
      error_element.text
    end
  end

  class GiftingRegistrationForm < PageModels::BlinkboxbooksSection
    element :email, '#email'
    element :first_name, '#first_name'
    element :last_name, '#last_name'
    element :club_card, '#clubcard'
    element :password, '#password'
    element :password_repeat, '#repassword'
    element :terms_and_conditions, '#termsconditions'
    element :newsletter_checkbox, '#newsletter'
    element :show_password, '#show'
    element :register_button, 'button[data-test="register-button"]'
    element :have_an_account, '[data-test="already-have-an-account"]'
    element :dont_have_an_account, '[data-test="dont-have-an-account"]'
    element :error_element, '#error_signin'

    def submit(first_name, last_name, email_address, password)
      self.first_name.set first_name
      self.last_name.set last_name
      self.email.set email_address
      self.password.set password
      self.password_repeat.set password
      self.terms_and_conditions.set true
      self.register_button.click
    end

    def displayed?
      self.first_name.visible? && self.last_name.visible? && self.register_button.visible?
    end

    def error_message
      error_element.text
    end
  end

  class VoucherRedemptionPage < PageModels::BlinkboxbooksPage
    set_url '/#!/redeem'
    set_url_matcher /redeem/

    #redemption stage 1
    element :voucher_code, '[data-test="voucher-code-text-box"]'
    element :use_this_code_button, '[data-test="check-voucher-code-button"]'
    element :validation_error_element, '.errors'

    #redemption stage 2
    element :add_free_credit_button, '[data-test="redeem-voucher-button"]'

    #signin form
    section :sign_in_form, GiftingSignInForm, '[ng-if="signUserInNow"]'

    #registration form
    section :registration_form, GiftingRegistrationForm, '[ng-show="registerUserNow"]'

    #redemption success page
    element :confirmation_message, '#content'
    element :start_shopping_button, '.final-stage'

    def submit_code(code)
      voucher_code.set code
      use_this_code_button.click
    end

    def submit_sign_in_details(email, password)
      sign_in_form.submit(email, password)
    end

    def submit_registration_details(first_name, last_name, email_address, password)
      registration_form.submit(first_name, last_name, email_address, password)
    end

    def validation_error
      validation_error_element.text
    end

  end

  register_model_caller_method(VoucherRedemptionPage)
end
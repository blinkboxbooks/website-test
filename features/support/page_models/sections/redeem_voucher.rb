module PageModels
  class RedeemVoucher < PageModels::BlinkboxbooksSection
    element :voucher_code, '[data-test="voucher-code-text-box"]'
    element :use_this_code_button, '[data-test="check-voucher-code-button"]'
    element :add_free_credit, '[data-test="redeem-voucher-button"]'
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
    element :have_an_account, '["data-test=already-have-an-account"]'
    element :dont_have_an_account, '["data-test=dont-have-an-account"]'

    #element :cancel_registration, 'a[data-test="cancel-registration"]'
    #element :confirm_cancel_registration, 'button', :text =>  /Leave This Page/i
    #element :cancel_registration_popup, '#delete-card'
    #element :sign_in_with_existing_email_link, '#error_signin a'
    #element :errors_section, '#error_signin'
    #element :sign_email_link, 'a', :text => /Sign in with/i
  end

  class RedeemRegister < PageModels::BlinkboxbooksSection; end

  class RedeemSignIn < PageModels::BlinkboxbooksSection; end
end

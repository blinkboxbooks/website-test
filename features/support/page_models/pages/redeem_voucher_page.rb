module PageModels
 class VoucherRedemptionPage < PageModels::BlinkboxbooksPage
   set_url '/#!/redeem'
   set_url_matcher /redeem/

   #redemption stage 1
   element :voucher_code, '[data-test="voucher-code-text-box"]'
   element :use_this_code_button, '[data-test="check-voucher-code-button"]'

   #redemption stage 2
   element :add_free_credit_button, '[data-test="redeem-voucher-button"]'


   #signin form
   element :signin_email, '[data-test="email-address"]'
   element :signin_password, '[data-test="password"]'
   element :signin_button, '[data-test="signin-button"]'

   #registration form
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

   #redemption success page
   element :confirmation_message, '#content'
   element :start_shopping_button, '.final-stage'

   def submit_code(code)
     voucher_code.set code
     use_this_code_button.click
   end

   def verify_confirmation_message
     wait_for_start_shopping_button
     wait_until_start_shopping_button_visible
     expect(confirmation_message.text).to include("You've now got £5 of free credit to spend!")
   end

   def submit_partial_login
     signin_email.set(test_data('emails', 'used_voucher'))
     signin_button.click
   end

   def submit_sign_in
     signin_email.set(test_data('emails', 'used_voucher'))
     signin_password.set(test_data('passwords', 'valid_password'))
     signin_button.click
   end

   def input_personal_details(email_address=@email_address)
     email_address ||= generate_random_email_address
     first_name = generate_random_first_name
     last_name = generate_random_last_name
     fill_in_personal_details(first_name, last_name, email_address)
     return email_address, first_name, last_name
   end


   def fill_in_personal_details(first_name, last_name, email_address)
     self.first_name.set first_name
     self.last_name.set last_name
     self.email.set email_address
   end

 end
 register_model_caller_method(VoucherRedemptionPage)
end
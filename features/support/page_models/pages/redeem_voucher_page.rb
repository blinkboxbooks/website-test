module PageModels
 class RedeemVoucherPage < PageModels::BlinkboxbooksPage
   set_url '/#!/redeem'
   set_url_matcher /redeem/

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

   def enter_voucher(value)
     voucher_code.set (value)
   end

 end
 register_model_caller_method(RedeemVoucherPage)
end
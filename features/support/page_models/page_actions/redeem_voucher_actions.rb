module PageModels
  module RedeemVoucherActions
    def enter_valid_voucher_code
      redeem_voucher_page.enter_voucher(test_data('vouchers', 'valid_voucher'))
    end

    def click_use_this_code
      redeem_voucher_page.use_this_code_button.click
    end

  end
end
World(PageModels::RedeemVoucherActions)
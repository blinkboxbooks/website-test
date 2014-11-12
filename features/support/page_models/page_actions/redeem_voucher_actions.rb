module PageModels
  module RedeemVoucherActions
    def enter_valid_voucher_code
      voucher_redemption_page.enter_voucher(test_data('vouchers', 'valid_voucher'))
    end

    def click_use_this_code
      voucher_redemption_page.use_this_code_button.click
    end

  end
end
World(PageModels::RedeemVoucherActions)
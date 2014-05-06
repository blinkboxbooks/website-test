module PageModels
  module BuyActions

    def enter_card_number(number)
      fill_form_element('number_card', number)
    end

    def select_expiry_date (month, year)
      select_value('card_dates_month', month)
      select_value('card_dates_year', year)
    end

    def enter_cvv(card_type)
      cvv='123'
      if (card_type.eql?('American Express'))
        cvv='1234'
      end
      fill_form_element('number_cvv', cvv)
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

    def enter_billing_details
      enter_address_line_one(test_data('payment', 'address_lineone'))
      enter_address_line_two(test_data('payment', 'address_linetwo'))
      enter_town_or_city(test_data('payment', 'town_or_city'))
      enter_post_code(test_data('payment', 'postcode'))
    end

    def enter_billing_details_with_missing(empty_field)
      enter_address_line_one(test_data('payment', 'address_lineone')) unless empty_field == 'Address line one'
      enter_address_line_two(test_data('payment', 'address_linetwo'))
      enter_town_or_city(test_data('payment', 'town_or_city')) unless empty_field == 'Town or city'
      enter_post_code(test_data('payment', 'postcode')) unless empty_field == 'Postcode'
    end

    def enter_invalid_billing_details(invalid_field, type)
      if type == 'numeric'
        value = rand(10000..99999)
      elsif type == 'character'
        value = ''
        5.times { value += ('a'..'z').to_a.sample }
      else
        value = type
      end
      invalid_field == 'address line one' ? address_line_one = value : address_line_one = test_data('payment', 'address_lineone')
      invalid_field == 'address line two' ? address_line_two = value : address_line_two = test_data('payment', 'address_linetwo')
      invalid_field == 'town or city' ? town_or_city = value : town_or_city = test_data('payment', 'town_or_city')
      invalid_field == 'post code' ? post_code = value : post_code = test_data('payment', 'postcode')
      enter_address_line_one(address_line_one)
      enter_address_line_two(address_line_two)
      enter_town_or_city(town_or_city)
      enter_post_code(post_code)
    end

    def click_confirm_and_pay
      confirm_and_pay_page.wait_for_confirm_and_pay
      confirm_and_pay_page.confirm_and_pay.click
      expect_page_displayed("Order Complete")
    end

    def click_confirm_order
      confirm_and_pay_page.wait_for_confirm_order
      confirm_and_pay_page.confirm_order.click
      expect_page_displayed("Order Complete")
    end

    def pay_with_saved_card
      confirm_and_pay_page.wait_for_details_view
      page.should have_text(:visible, 'Your saved card details')
      click_confirm_and_pay
    end

    def click_pay_with_new_card
      confirm_and_pay_page.pay_with_new_card.click
    end

    def pay_with_new_card(card_type)
      enter_card_details(set_valid_card_details(card_type))
      click_confirm_and_pay
    end

    def choose_to_save_card_details()
      unless confirm_and_pay_page.save_card.checked?
        confirm_and_pay_page.save_card.click
      end
    end

    def choose_not_to_save_card_details()
      if confirm_and_pay_page.save_card.checked?
        confirm_and_pay_page.save_card.click
      end
    end

    def click_read_offline
      book_details_page.read_offline.should be_visible
      book_details_page.read_offline.click
    end

    def click_buy_now_in_book_details_page
      book_details_page.buy_now.click
    end

    def cancel_order
      confirm_and_pay_page.cancel_order_link.click
    end

    def confirm_cancel_order
      page.should have_selector('#delete-card')
      confirm_and_pay_page.confirm_cancel_button.click
    end

    def submit_new_payment_with_not_matching_cvv (cvv_number = '200')
      card_details = set_valid_card_details('VISA')
      card_details[:cvv] = cvv_number
      enter_card_details(card_details)
      enter_billing_details
      choose_not_to_save_card_details
      confirm_and_pay_page.confirm_and_pay.click
    end

    def enter_card_details(card_details)
      confirm_and_pay_page.card_number.set card_details[:card_number]
      confirm_and_pay_page.cvv.set card_details[:cvv]
      confirm_and_pay_page.expiry_month.select card_details[:expiry_month]
      confirm_and_pay_page.expiry_year.select card_details[:expiry_year]
      confirm_and_pay_page.name_on_card.set card_details[:name_on_card]
    end

    def submit_empty_new_payments_form
      confirm_and_pay_page.confirm_and_pay.click
    end

    def save_card(save_payment)
      if save_payment
        choose_to_save_card_details
      else
        choose_not_to_save_card_details
      end
    end

    def set_valid_card_details(card_type)
      card_type=card_type.gsub(' ', '').downcase
      payment_details = {
          :card_number => test_data('payment', card_type),
          :expiry_month => test_data('payment', 'expiry_month'),
          :expiry_year => test_data('payment', 'expiry_year'),
          :name_on_card => generate_random_first_name,
          :cvv => test_data('payment', 'cvv')
      }
      return payment_details
    end

    def successful_new_payment(save_payment, card_type = 'VISA')
      card_details = set_valid_card_details(card_type)
      name_on_card = card_details[:name_on_card]
      enter_card_details(card_details)
      enter_billing_details
      save_card(save_payment)
      confirm_and_pay_page.confirm_and_pay.click
      expect_page_displayed('order complete')
      assert_order_complete
      return name_on_card, card_type
    end


  end
end
World(PageModels::BuyActions)




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

    def enter_new_payment_details(card_type)
      enter_card_number(get_card_number_by_type(card_type))
      select_expiry_date('12', '2023')
      enter_name_on_card('jamie jones')
      enter_cvv(card_type)
    end

    def enter_billing_details
      enter_address_line_one('my address line one')
      enter_address_line_two('my address line two')
      enter_town_or_city('My town')
      enter_post_code('WC18AQ')
    end

    def click_confirm_and_pay
      selector = confirm_and_pay_page.confirm_and_pay
      page.should have_selector(selector.tag_name, :text => selector.text)
      confirm_and_pay_page.confirm_and_pay.click
      expect_page_displayed("Order Complete")
    end

    def click_confirm_order
      selector = confirm_and_pay_page.confirm_order
      page.should have_selector(selector.tag_name, :text => selector.text)
      confirm_and_pay_page.confirm_order.click
      expect_page_displayed("Order Complete")
    end

    def pay_with_saved_card
      if (page.has_text?(:visible, 'Your saved card details'))
        click_confirm_and_pay
      end
    end

    def click_pay_with_new_card
      confirm_and_pay_page.pay_with_new_card.click
    end

    def pay_with_new_card(card_type)
      enter_new_payment_details(card_type)
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
      book_details_page.read_offline.click
    end

    def click_buy_now_in_book_details_page
      book_details_page.buy_now.click
      expect_page_displayed("Confirm and Pay")
    end

  end
end
World(PageModels::BuyActions)




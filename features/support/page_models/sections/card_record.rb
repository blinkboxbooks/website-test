module PageModels
  class CardRecord < PageModels::BlinkboxbooksSection
    element :holder_name_element, '.payment_holder_name'
    element :delete_card_link, '.delete_payment a'

    def card_holder_name
      holder_name_element.text
    end
  end
end
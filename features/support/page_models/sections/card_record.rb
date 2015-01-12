module PageModels
  class CardRecord < PageModels::BlinkboxbooksSection
    element :title_element, 'div.payment_card_details_container'
    element :holder_name_element, '.payment_holder_name'
    element :delete_link, '.delete_payment a'
    element :default_radio, 'div.payment_default input', :visible => false
    element :default_radio_label, 'div.payment_default label'
    element :card_image, 'span.card-image'

    def title
      title_element.text
    end

    def type
      card_image[:title]
    end

    def last_four_digits
      title_element[/\d{4}/]
    end

    def holder_name
      holder_name_element.text
    end

    def delete
      delete_link.click
    end

    def check_default_radio
      default_radio_label.click
    end

    def is_default?
      default_radio.checked?
    end
  end
end

module PageModels
  module AccountPagesActions
    def saved_cards
      your_payments_page.wait_until_saved_cards_container_visible
      your_payments_page.saved_cards
    end

    def delete_stored_card(index)
      cards = saved_cards.size
      if cards < index + 1
        raise "Cannot delete card No. #{index + 1}, because there's only #{cards} saved cards in the list!"
      else
        saved_cards[index].delete
        your_payments_page.wait_until_delete_card_popup_visible
        your_payments_page.delete_card_popup.confirm
        your_payments_page.wait_until_delete_card_popup_invisible
      end
    end

    def sign_out_from_account_page
      your_account_page.sign_out_button.click
    end
  end
end

World(PageModels::AccountPagesActions)

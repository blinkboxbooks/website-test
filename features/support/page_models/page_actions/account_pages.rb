module PageModels
  module AccountPagesActions
    def saved_cards
      your_payments_page.wait_for_saved_cards_list
      your_payments_page.saved_cards_list
    end

    def delete_stored_card(index)
      cards = saved_cards.size
      if cards < index + 1
        raise "Cannot delete card No. #{index + 1}, because there's only #{cards} saved cards in the list!"
      else
        saved_cards[index].delete
      end
      your_payments_page.wait_until_delete_card_popup_visible
      your_payments_page.delete_card_popup.delete_button.click
      your_payments_page.wait_until_delete_card_popup_invisible
    end
  end
end

World(PageModels::AccountPagesActions)
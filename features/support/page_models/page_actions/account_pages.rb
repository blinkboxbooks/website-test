module PageModels
  module AccountPagesActions
    def delete_stored_card(index)
      your_payments_page.wait_for_saved_cards_list
      saved_cards_list = your_payments_page.saved_cards_list
      if saved_cards_list.size < index + 1
        raise "Cannot delete card No. #{index}, because there's only #{saved_cards_list.size} saved cards in the list!"
      else
        saved_cards_list[index].delete_card_link.click
      end
      your_payments_page.wait_until_delete_card_popup_visible
      your_payments_page.delete_card_popup.delete_button.click
      your_payments_page.wait_until_delete_card_popup_invisible
    end
  end
end

World(PageModels::AccountPagesActions)
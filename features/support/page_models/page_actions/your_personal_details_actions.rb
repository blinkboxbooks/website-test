module PageModels
  module YourPersonalDetailsActions

    def enter_clubcard (clubcard_number)
      your_personal_details_page.wait_until_club_card_visible
      delete_clubcard
      your_personal_details_page.club_card.set clubcard_number
    end

    def delete_clubcard
      sleep(1)
     until your_personal_details_page.club_card.value.empty? do
       your_personal_details_page.club_card.native.send_keys(:backspace)

     end
    end

    def submit_personal_details
      your_personal_details_page.wait_until_update_personal_details_visible
      your_personal_details_page.update_personal_details.click
    end

  end
end
World(PageModels::YourPersonalDetailsActions)
module PageModels
  module YourPersonalDetailsActions
    def enter_clubcard(clubcard_number, args = { :submit => false })
      your_personal_details_page.wait_until_club_card_visible
      delete_clubcard
      your_personal_details_page.club_card.set clubcard_number
      submit_personal_details if args[:submit]
      clubcard_number
    end

    def delete_clubcard
      your_personal_details_page.wait_until_club_card_visible
      until your_personal_details_page.club_card.value.empty?
        your_personal_details_page.club_card.native.send_keys(:backspace)
      end
    end

    def submit_personal_details
      your_personal_details_page.wait_until_update_personal_details_visible
      your_personal_details_page.update_personal_details.click
    end

    def set_random_email_address
      new_email_address = generate_random_email_address
      your_personal_details_page.email_address.set new_email_address
      new_email_address
    end

    def show_change_your_password_section
      click_link_from_my_account_dropdown('Personal details')
      your_personal_details_page.change_password_link.click
    end

    def update_account_password(current_password, new_password)
      update_password(current_password, new_password)
      new_password
    end

    def update_email_address(email_address)
      wait_until { !your_personal_details_page.email_address.value.empty? }
      email_before = your_personal_details_page.email_address.value
      your_personal_details_page.email_address.set(email_address)
      your_personal_details_page.update_personal_details.click
      your_personal_details_page.email_address.value
      email_before
    end
  end
end

World(PageModels::YourPersonalDetailsActions)

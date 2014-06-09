module ManageAccount
  def click_link_from_my_account_dropdown(link_name)
    # TODO: Remove when hamburger menu is rolled out
    current_page.header.user_account_logo.click

    link = current_page.header.find_link_by_text(link_name)

    unless link.nil?
      link.click
    else
      expect(current_page.header).to be_visible
      current_page.header.navigate_to_account_option(link_name)
    end
  end

  def edit_personal_details
    first_name = generate_random_first_name
    last_name = generate_random_last_name
    puts "Changing first name from '#{your_personal_details_page.first_name.value}' to '#{first_name}'"
    puts "Changing last name from '#{your_personal_details_page.first_name.value}' to '#{last_name}'"
    your_personal_details_page.first_name.set first_name
    your_personal_details_page.last_name.set last_name
    return first_name, last_name
  end

  def set_card_default
    your_payments_page.wait_for_saved_cards_list
    saved_cards_list = your_payments_page.saved_cards
    unless saved_cards_list.empty?
      saved_cards_list.each { |card|
        unless card.is_default?
          card.check_default_radio
          @default_card = card.title + card.holder_name
          break
        end
      }
    else
      raise 'Saved cards list on Your Payments page is empty!'
    end

    click_button('Update default card')
    return @default_card
  end

end

module CommonActions
  def app_version_info
    current_page.footer.version_info
  end
end

World(ManageAccount)
World(CommonActions)

module ManageAccount
  def click_link_from_my_account_dropdown(link_name)
    current_page.header.navigate_to_account_option(link_name)
  end

  def edit_personal_details
    first_name = generate_random_first_name
    last_name = generate_random_last_name
    puts "Changing first name from '#{your_personal_details_page.first_name}' to '#{first_name}'"
    puts "Changing last name from '#{your_personal_details_page.first_name}' to '#{last_name}'"
    your_personal_details_page.first_name_element.set first_name
    your_personal_details_page.last_name_element.set last_name
    return first_name, last_name
  end

  def set_card_default
    your_payments_page.wait_for_saved_cards_list
    saved_cards_list = your_payments_page.saved_cards
    if !saved_cards_list.empty?
      saved_cards_list.each do |card|
        unless card.is_default?
          card.check_default_radio
          @default_card = card.title + card.holder_name
          break
        end
      end
    else
      fail 'Saved cards list on Your Payments page is empty!'
    end

    click_button('Update default card')
    @default_card
  end

  def set_viewing_mode(viewing_mode)
    case viewing_mode
    when 'Desktop'
      maximize_window
    when 'Mobile Portrait'
      resize_window(320, 480)
    when 'Mobile Landscape'
      resize_window(480, 320)
    when '10 inch tablet'
      resize_window(800, 1024)
    when '7 inch tablet'
      resize_window(550, 1024)
    else
      fail "Unsupported browser viewing mode: #{viewing_mode}"
    end
  end
end

module CommonActions
  def app_version_info
    current_page.footer.version_info
  end

  def click_navigation_link(page_name)
    current_page.header.navigate_to page_name
  end
end

World(ManageAccount)
World(CommonActions)

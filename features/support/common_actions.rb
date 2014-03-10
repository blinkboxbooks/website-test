module ManageAccount
  def click_link_from_my_account_dropdown(link_name)
    current_page.header.should be_visible
    current_page.header.navigate_to_account_option(link_name)
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

  def navigate_to_my_account_landing_page
    within(find('[id="username"]')) do
      first('a').click
    end
  end

  def click_on_my_account_tab(tab_name)
    within('.account_menu') do
      page.all('li').to_a.each do |li|
        if li.text.eql?(tab_name)
          li.click
        end
      end
    end
  end

  def edit_marketing_preferences
    before_status = page.has_checked_field?('newsletter')
    if (before_status)
      uncheck('newsletter')
    else
      check('newsletter')
    end
    after_status = page.has_checked_field?('newsletter')
    return after_status
  end

  def set_card_default
    within('.payment_list') do
      page.all('li').to_a.each do |li|
        if not ((li[:class]).include?('payment_alt_row'))
          within(li) do
            within('[class="payment_default"]') do
              find('label').click
            end
            within('[class="payment_card_details_container"]') do
              @default_card = find('[class="payment_name ng-binding"]').text
            end
          end
          break
        end
      end
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






module WebUtilities

  def find_a_text selector, type
    within(selector) do
      case type
        when 'author'
          @actual_text = find('[data-test="book-authors"]')[:title]

        when 'title'
          @actual_text= find('[data-test="book-title"]')[:title]
      end
    end
    return @actual_text
  end

  def generate_random_email_address
    first_part = 'cucumber_test'
    last_part = '@blinkboxbooks.com'
    middle_part = rand(1..9999).to_s
    return first_part+middle_part+last_part
  end

  def generate_random_first_name
    first_part = 'firstname-autotest-'
    last_part=(0...10).map { ('a'..'z').to_a[rand(26)] }.join
    return first_part + last_part
  end
  
  def generate_random_last_name
    first_part = 'lastname-autotest-'
    last_part=(0...10).map { ('a'..'z').to_a[rand(26)] }.join
    return first_part + last_part
  end

  def delete_cookies
    Capybara.current_session.reset_session!
  end

  def fill_form_element (element, value)
    fill_in("#{element}", :with => "#{value}")
  end

  def click_link_or_button (element_id)
    find("[data-test='#{element_id}']").click
  end

  def select_value(element, value)
    select(value, :from => element)
  end
end


World(WebUtilities)

module Utilities
  def generate_random_email_address
    first_part = 'cucumber_test'
    last_part = '@mobcastdev.com'
    middle_part = rand(1..9999).to_s + (0...10).map { ('a'..'z').to_a[rand(26)] }.join
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

  def return_search_word_for_book_type (book_type)
    return book_type.eql?('free') ? 'free' : 'summer'
  end
end

module WebUtilities

  def cookie_manager
    case Capybara.current_session.driver
      when Capybara::Selenium::Driver
        cookie_manager = page.driver.browser.manage
      else
        raise "no cookie-setter implemented for driver #{Capybara.current_session.driver.class.name}"
    end
    cookie_manager
  end

  def get_cookie(name)
    cookie_manager.cookie_named('access_token')
  end

  def set_cookie(name, value)
    cookie_manager.add_cookie(:name => name, :value => value)
  end

  def delete_cookie(name)
    cookie_manager.delete_cookie(name)
  end

  def delete_all_cookies
    reset_session
  end

  def reset_session!
    Capybara.current_session.reset_session!
  end

  def find_a_text selector, type
    within(selector) do
      case type
        when 'author'
          actual_text = find('[data-test="book-authors"]')[:title]
        when 'title'
          actual_text= find('[data-test="book-title"]')[:title]
      end
    end
    actual_text
  end

  def fill_form_element(element, value)
    # TODO: CWA-1455 - I keep this, until there's usage
    fill_in("#{element}", :with => "#{value}")
  end

  def click_link_or_button(element_id)
    find("[data-test='#{element_id}']").click
  end

  def select_value(element, value)
    select(value, :from => element)
  end

  def mouse_over(element)
    if Capybara.current_session.driver == Capybara::Selenium::Driver
      element.native.location_once_scrolled_into_view
      page.driver.browser.action.move_to(element.native).perform
    end
    element.hover
  end

  def maximize_window
    page.driver.browser.manage.window.maximize
  end

  def resize_window(x, y)
    page.driver.browser.manage.window.resize_to(x, y)
  end

  def refresh_current_page
    page.driver.browser.navigate.refresh
    current_page.wait_until_header_visible(10)
  end

end

module BlinkboxWebUtilities
  def set_start_cookie_accepted
    visit('/') unless current_path == '/'
    set_cookie("start_cookie_accepted", "true")
    visit('/')
  end

  def delete_access_token_cookie
    delete_cookie('access_token')
  rescue
  end

  def logged_in_session?
    !current_page.header.welcome.text(:visible).empty?
  end

  def log_out_current_session
    current_page.header.user_account_logo.click
    current_page.header.account_menu.sign_out_button.click
  end

  def assert_support_page(page_name)
    assert_browser_count(2)
    new_window = page.driver.browser.window_handles.last
    page.within_window new_window do
      current_url.should match Regexp.new(test_data('support_page_urls', page_name.downcase.gsub(' ', '_')))
      page.driver.browser.close
    end
    assert_browser_count(1)
  end

  def assert_browser_count(count)
    browser_windows = page.driver.browser.window_handles
    expect(browser_windows.count).to be == count.to_i, "expected #{count.to_s} browser windows to be opened, got #{browser_windows.count.to_s}"
  end

end

World(Utilities)
World(WebUtilities)
World(BlinkboxWebUtilities)

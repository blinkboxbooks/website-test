# encoding: utf-8

module Utilities
  def generate_random_email_address
    first_part = 'cucumber_test'
    last_part = '@mobcastdev.com'
    middle_part = rand(1..9999).to_s + (0...10).map { ('a'..'z').to_a[rand(26)] }.join
    first_part+middle_part+last_part
  end

  def generate_random_first_name
    first_part = 'firstname-autotest-'
    last_part=(0...10).map { ('a'..'z').to_a[rand(26)] }.join
    first_part + last_part
  end

  def generate_random_last_name
    first_part = 'lastname-autotest-'
    last_part=(0...10).map { ('a'..'z').to_a[rand(26)] }.join
    first_part + last_part
  end

  def return_search_word_for_book_type (book_type)
    random_words = test_list('random_search_keywords')
    book_type == :free ? 'free' : random_words.sample
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

  def get_cookie(name = 'access_token')
    cookie_manager.cookie_named(name)
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

  def go_back
    page.evaluate_script('window.history.back()')
  end

end

module BlinkboxWebUtilities
  def set_start_cookie_accepted
    visit('/') unless current_path == '/'
    set_cookie('start_cookie_accepted', 'true')
    visit('/')
  end

  def delete_access_token_cookie
    delete_cookie('access_token')
  rescue
    puts 'A problem occurred while deleting the access_token cookie!'
  end

  def logged_in_session?
    current_page.header.logged_in?
  end

  def log_out_current_session
    current_page.header.user_account_logo.click
    current_page.header.account_menu.sign_out_button.click
  end

  def assert_support_page(page_name)
    assert_browser_count(2)
    new_window = page.driver.browser.window_handles.last
    page.within_window new_window do
      wait_until { page.current_url.include?('support') }
      expect(current_url).to match(Regexp.new(test_data('support_page_urls', page_name.downcase.gsub(' ', '_'))))
      page.driver.browser.close
    end
    assert_browser_count(1)
  end

  def assert_browser_count(count)
    browser_windows = page.driver.browser.window_handles
    expect(browser_windows.count).to eq(count), "expected #{count} browser windows to be opened, got #{browser_windows.count}"
  end

end

module BrowserstackUtilities

  require 'childprocess'
  require 'uri'

  class BrowserstackTunnel

    attr_accessor :binary
    attr_accessor :process
    attr_accessor :log
    attr_accessor :log_filename
    attr_accessor :host
    attr_accessor :port
    attr_accessor :access_key

    def initialize(access_key, uri, ssl = true)
      bin = 'BrowserStackLocal'
      @binary = bin

      @log_filename = "browserstack-tunnel-#{Time.now.to_i}.log"
      @log = File.open(@log_filename, "w")
      @process = nil

      uri += ':443' unless uri =~ /:\d+/
      @server_uri = URI(uri)

      @ssl = ssl
      @access_key = access_key
    end

    def start
      puts("Starting BrowserStack Tunnel...")
      process.start

      # Wait until Selenium Server fully starts
      until is_started()
        # Do nothing, just wait. Todo: Implement a timeout!
        if is_exiting()
          stop
          raise "Something went wrong during startup of BrowserStack binary... Please check logfile: #{@log_filename}"
        end
      end
      puts "Tunnel for #{server_info} started!\n\n"
    end

    def stop
      puts "Stopping..."
      stop_process if @process
      @log.close if @log
    end

    def stop_process
      return unless @process.alive?

      begin
        @process.poll_for_exit(5)
      rescue ChildProcess::TimeoutError
        @process.stop
      end
    rescue Errno::ECHILD
      # already dead
    ensure
      @process = nil
    end

    def process
      @process ||= (
        puts "Starting BrowserStack proxy for #{server_info}"
        cp = ChildProcess.new(@binary, '-force', '-onlyAutomate', @access_key, server_info_for_process)
        cp.detach = true # Start in the background
        cp.io.stdout = cp.io.stderr = @log
        cp
      )
    end

    def server_info_for_process
      "#{@server_uri.host.to_s},#{@server_uri.port.to_s},#{@ssl ? 1 : 0}"
    end 

    def server_info
      "#{@server_uri.host.to_s}:#{@server_uri.port.to_s}"
    end

    def is_started
      File.read(@log_filename).encode!('UTF-8', 'UTF-8', :invalid => :replace).each_line { |line| return true if line.include?('You can now access your local server(s) in our remote browser:') }
      false
    end

    def is_exiting
      File.read(@log_filename).encode!('UTF-8', 'UTF-8', :invalid => :replace).each_line { |line| return true if line =~ /\*\*\* Error:/ }
      false
    end
  end

end

World(Utilities)
World(WebUtilities)
World(BlinkboxWebUtilities)
World(BrowserstackUtilities)

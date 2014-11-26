# encoding: utf-8

module Utilities
  def generate_random_email_address
    first_part = 'cucumber_test'
    last_part = '@mobcastdev.com'
    middle_part = rand(1..9999).to_s + (0...10).map { ('a'..'z').to_a[rand(26)] }.join
    first_part + middle_part + last_part
  end

  def generate_random_first_name
    first_part = 'firstname-autotest-'
    last_part = (0...10).map { ('a'..'z').to_a[rand(26)] }.join
    first_part + last_part
  end

  def generate_random_last_name
    first_part = 'lastname-autotest-'
    last_part = (0...10).map { ('a'..'z').to_a[rand(26)] }.join
    first_part + last_part
  end

  def return_search_word_for_book_type(book_type)
    book_type.to_sym == :free ? 'free' : test_data_sample('random_search_keywords')
  end

  def isbn_for_book_type(book_type)
    test_data('library_isbns', book_type.to_s)
  rescue => e
    raise "Cannot return isbn for unknown book type: #{book_type}\n \nTest Data Error: #{e.message}"
  end
end

module WebUtilities
  def cookie_manager
    case Capybara.current_session.driver
    when Capybara::Selenium::Driver
      cookie_manager = page.driver.browser.manage
    else
      fail "no cookie-setter implemented for driver #{Capybara.current_session.driver.class.name}"
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

  def clear_text_field(element)
    wait_until { element.visible? }
    until element.value.empty? do
      element.native.send_keys(:backspace)
    end
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

  def open_windows
    page.driver.browser.window_handles
  end

  def close_last_open_browser_window
    page.within_window last_open_browser_window do
      page.driver.browser.close
    end
  end

  def close_excessive_browser_windows
    while open_windows.count > 1
      close_last_open_browser_window
    end
  end

  def last_open_browser_window
    open_windows.last
  end

  def js_errors
    page.driver.browser.manage.logs.get('browser')
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
end

module BrowserstackUtilities
  require 'childprocess'
  require 'uri'
  require 'timeout'

  class BrowserstackTunnel
    attr_accessor :binary, :process, :log, :log_filename, :host, :port, :access_key

    def initialize(access_key, uri, ssl = true)
      bin = 'BrowserStackLocal'
      @binary = bin

      @log_filename = "results/browserstack-tunnel-#{Time.now.to_i}.log"
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
      # Wait until the tunnel is established
      wait_until do
        if is_exiting
          stop
          fail "Something went wrong during startup of BrowserStack binary... Please check logfile: #{@log_filename}"
        end
        is_started
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
      puts 'already dead'
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
      "#{@server_uri.host},#{@server_uri.port},#{@ssl ? 1 : 0}"
    end

    def server_info
      "#{@server_uri.host}:#{@server_uri.port}"
    end

    def is_started
      File.read(@log_filename).encode!('UTF-8', 'UTF-8', :invalid => :replace).each_line { |line| return true if line.include?('You can now access your local server(s) in our remote browser') }
      false
    end

    def is_exiting
      File.read(@log_filename).encode!('UTF-8', 'UTF-8', :invalid => :replace).each_line { |line| return true if line =~ /\*\*\* Error:/ }
      false
    end

    def wait_until
      require 'timeout'
      Timeout.timeout(30) do
        sleep(0.1) until value == yield
        value
      end
    end
  end
end

World(Utilities)
World(WebUtilities)
World(BlinkboxWebUtilities)
World(BrowserstackUtilities)

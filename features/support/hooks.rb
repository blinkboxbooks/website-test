Before('~@reset_session') do
  visit('/') unless current_path == '/'
  maximize_window
  puts "Web App Version: #{app_version_info}"
  if logged_in_session?
    log_out_current_session
    current_page.header.user_account_logo.click
  end
end

After do |scenario|
  if TEST_CONFIG['js_log']
    puts 'JS LOG ENTRIES:'
    js_errors.each { |entry| puts "#{entry.level}: #{entry.message}" }
  end

  if open_windows.count > 0
    #navigate to a home page, if current page has no menu in the header to do the user sign out
    home_page.load unless current_page.header.has_account_menu?
    log_out_current_session if logged_in_session?
  end

  close_excessive_browser_windows

  if TEST_CONFIG && TEST_CONFIG['fail_fast']
    puts "'FAIL FAST' option is ON"
    # Tell Cucumber to quit after this scenario is done - if it failed
    if scenario.failed?
      puts "Terminating the run after the first failure for quicker feedback.\n" +
               'See above for the actual failure, or check the HTML report.'
      Cucumber.wants_to_quit = true
    end
  end
  $browser_stack_tunnel.stop unless $browser_stack_tunnel.nil?

end

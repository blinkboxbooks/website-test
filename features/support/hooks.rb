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
  if page.driver.browser.window_handles.count > 0 && logged_in_session?
    log_out_current_session
  end
  
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

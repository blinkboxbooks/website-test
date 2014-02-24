Before("~@reset_session") do
  maximize_window
  puts "Web App Version: #{app_version_info}"
  if logged_in_session?
    log_out_current_session
    current_page.header.user_account_logo.click
  end
end

After do |scenario|
  if TEST_CONFIG["fail_fast"]
    puts "'FAIL FAST' option is ON"
    # Tell Cucumber to quit after this scenario is done - if it failed
    if scenario.failed?
      puts "Terminating the run after the first failure for quicker feedback.\n" +
               "See above for the actual failure, or check the HTML report."
      Cucumber.wants_to_quit = true
    end
  end

end

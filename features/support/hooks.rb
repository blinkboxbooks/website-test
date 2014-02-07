Before("~@reset_session") do
  set_start_cookie_accepted
  maximize_window
  puts "Web App Version: #{app_version_info}"
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
     if(current_page.header.find('.username', :text =>'Hi', :wait =>0))
      click_link_from_my_account_dropdown('Sign out')
      raise "User is already signed out, continue with test execution"
     end

  end

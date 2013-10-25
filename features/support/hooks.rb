Before("~@reset_session") do
  set_start_cookie_accepted
  maximize_window
  puts "Web App Version: #{app_version_info}"
end
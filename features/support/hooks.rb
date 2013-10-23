Before("~@reset_session") do
  visit('/')
  set_cookie("start_cookie_accepted", "true")
  maximize_window
end
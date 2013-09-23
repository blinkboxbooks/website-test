module WebUtilities

def find_a_text selector,type
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
  first_part = 'autotest-'
  last_part=(0...10).map{ ('a'..'z').to_a[rand(26)] }.join
  return  first_part + last_part
end

def delete_cookies
  Capybara.current_session.reset_session!
end
end

World(WebUtilities)

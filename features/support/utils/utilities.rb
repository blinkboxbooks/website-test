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
    if TEST_CONFIG['server']=~/QA/i
      book_type.to_sym == :free ? 'free' : 'love'
    else
      book_type.to_sym == :free ? 'free' : test_data_sample('random_search_keywords')
    end
  end

  def isbn_for_book_type(book_type)
    test_data('library_isbns', book_type.to_s)
  rescue => e
    raise "Cannot return isbn for unknown book type: #{book_type}\n \nTest Data Error: #{e.message}\n#{e.backtrace}"
  end
end

World(Utilities)

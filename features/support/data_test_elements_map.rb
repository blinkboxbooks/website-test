module TestElementsMap
  DATA_TEST_ELEMENTS = {'Featured' => 'header-featured',
                        'Categories' => 'header-categories-link',
                        'Best sellers' => 'header-bestsellers-link',
                        'New releases' => 'header-new-releases-link',
                        'Free books' => 'header-top-free-link',
                        'Authors' => 'header-authors-link',
                        'Best sellers section' => 'bestsellers-container',
                        'New releases section' => 'newreleases-title',
                        'Free books section' => 'topfree-container',
                        'Featured Authors section' => 'featured_authors',
                        'Best selling authors section' => 'authors-container',
                        'Copyright' => 'footer-copyright-text',
                        'Music link' => 'footer-music-link"',
                        'Movies link' => 'footer-movies-link',
                        'Sitemap' => 'footer-sitemap-link',
                        'Terms & conditions' => 'footer-t-and-c-link',
                        'Footer help link' => 'footer-help-link',
                        'About Blinkbox Books' => 'footer-about-link',
                        'Header Sign in' => 'header-sign-in-link',
                        'Footer container' => 'footer-sitemap-link',
                        'iOS app link' => 'footer-t-and-c-link',
                        'Android app link' => 'footer-help-link',
                        'Pintrest' => 'footer-pintrest-link',
                        'Twitter' => 'footer-twitter-link',
                        'Facebook' => 'footer-facebook-link',
                        'Connect with us container' => 'footer-connect-with-us-container',
                        'Footer new release container' => 'footer-new-releases-container',
                        'Footer Author 2' => 'footer-top-authors-in-crime-container',
                        'Footer Author' => 'footer-top-authors-container',
                        'Main footer container' => 'footer-container',
                        'Buy Now' => 'book-buy-button',
                        'Sign in' => 'header-sign-in-link'}

  TEST_CARD_NUMBERS = {'VISA' => '4111111111111111',
                       'American Express' => '3782 822463 10005',
                       'Mastercard' => '5555555555554444',
                       'VISA Debit' => '4012000033330125'}

  TEXT_MESSAGES = {'Welcome' => 'Welcome, book lover Your account is now set up. Feel free to discover a world of books with our helpful reviews and recommendations. We hope you get the most out of blinkbox books. Start shopping'}

  SUPPORT_PAGE_URLS = {'support home' => 'support.blinkboxbooks.com/home',
                       'What devices can I use to read my books?' => 'support.blinkboxbooks.com/entries/25400608',
                       'I bought a book but can\'t find it' => 'support.blinkboxbooks.com/entries/25378796',
                       'How do I read books in the app?' => 'support.blinkboxbooks.com/entries/25462193',
                       'How do I change my billing address?' => 'support.blinkboxbooks.com/entries/25384827',
                       'How can I earn Tesco Clubcard points?' => 'support.blinkboxbooks.com/entries/25385867',
                       'Can I delete my blinkbox books account?' => 'support.blinkboxbooks.com/entries/25377036',
                       'How do I add a new payment method?' => 'support.blinkboxbooks.com/entries/25385467',
                       'What are my payment options?' => 'support.blinkboxbooks.com/entries/23868518',
                       'Do you accept gift cards?' => 'support.blinkboxbooks.com/entries/25385517',
                       'What devices can I use to read my books?' => 'support.blinkboxbooks.com/entries/25400608',
                       'How do I download the app?' => 'support.blinkboxbooks.com/entries/25378706',
                       'Problems installing the app' => 'support.blinkboxbooks.com/entries/25378726'}

  def get_element_id_for(element_name)
    if DATA_TEST_ELEMENTS.key?(element_name)
      return DATA_TEST_ELEMENTS[element_name]
    end
    element_name
  end

  def get_card_number_by_type(card_type)
    if TEST_CARD_NUMBERS.key?(card_type)
      return TEST_CARD_NUMBERS[card_type]
    end
  end

  def get_message_text(message_type)
    if TEXT_MESSAGES.key?(message_type)
      return TEXT_MESSAGES[message_type]
    end
  end

  def get_support_page_url(page_name)
    if SUPPORT_PAGE_URLS.key?(page_name)
      return SUPPORT_PAGE_URLS[page_name]
    end
  end

end

World(TestElementsMap)



module TestElementsMap
  DATA_TEST_ELEMENTS = {'Categories' => 'header-categories-link',
                  'Best sellers' => 'header-bestsellers-link',
                  'New releases' => 'header-new-releases-link',
                  'Top free' => 'header-top-free-link',
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
                  'Android app link'=> 'footer-help-link',
                  'Pintrest' => 'footer-pintrest-link',
                  'Twitter' => 'footer-twitter-link',
                  'Facebook' => 'footer-facebook-link',
                  'Connect with us container'=> 'footer-connect-with-us-container',
                  'Footer new release container' => 'footer-new-releases-container',
                  'Footer Author 2' => 'footer-top-authors-in-crime-container',
                  'Footer Author' => 'footer-top-authors-container',
                  'Main footer container'=> 'footer-container',
                  'Buy Now' => 'book-buy-button',
                  'Sign in' => 'header-sign-in-link'}

  PAGE_URL_PATHS = { 'Categories' => '/#!/categories/',
                     'Best sellers' => '#!/bestsellers/',
                     'New releases' => '/#!/new',
                     'Top free' => '#!/topfree/',
                     'Authors' => '#!/authors/',
                     'Register' => '#!/register',
                     'Sign in' => '#!/signin',
                     'Terms and conditions' => '#!/terms_and_conditions',
                     'Confirm & pay' => '#!/confirm',
                     'Payment successful' => '#!/success',
                     'Account' => '#!/account'
                     }
  TEST_CARD_NUMBERS = { 'VISA' => '4111 1111 1111 1111'

  }

  def get_element_id_for(element_name)
    if DATA_TEST_ELEMENTS.key?(element_name)
      return DATA_TEST_ELEMENTS[element_name]
    end
    element_name
  end

  def get_page_url_path_for(page_name)
    if PAGE_URL_PATHS.key?(page_name)
      return PAGE_URL_PATHS[page_name]
    end
    page_name
  end

  def get_card_number_by_type(card_type)
    if TEST_CARD_NUMBERS.key?(card_type)
      return TEST_CARD_NUMBERS[card_type]
    end
  end
end

World(TestElementsMap)



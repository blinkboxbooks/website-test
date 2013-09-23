module DataTestElements
  ELEMENTS_MAP = {'Categories' => 'header-categories-link',
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
                  'Pintrest link' => 'footer-pintrest-link',
                  'Twitter link' => 'footer-twitter-link',
                  'Facebook link' => 'footer-facebook-link',
                  'Connect with us container'=> 'footer-connect-with-us-container',
                  'Footer new release container' => 'footer-new-releases-container',
                  'Footer Author 2' => 'footer-top-authors-in-crime-container',
                  'Footer Author' => 'footer-top-authors-container',
                  'Main footer container'=> 'footer-container'
                   }

  def get_element_id_for(element_name)
    if ELEMENTS_MAP.key?(element_name)
      return ELEMENTS_MAP[element_name]
    end
    element_name
  end
end

World(DataTestElements)



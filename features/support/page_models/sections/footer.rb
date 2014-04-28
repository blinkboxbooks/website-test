module PageModels
  class FooterLinks < PageModels::BlinkboxbooksSection
    element :about_blinkbox, "a[data-test='footer-about-link']"
    element :help, "a[data-test='footer-help-link']"
    element :terms_and_conditions, "a[data-test='footer-t-and-c-link']"
    element :blinkbox_movies, "a[data-test='footer-movies-link']"
    element :blinkbox_music, "a[data-test='footer-music-link']"
  end

  class Footer < PageModels::BlinkboxbooksSection
    element :version_div, "div.versionInfo", visible: false
    elements :top_authors, "div#footer_authors1 ul.lists li"
    elements :top_categories, "div#footer_categories ul.lists li"
    section :links, FooterLinks, "div#bottom_footer"

    def version_info
      version_div.text(:all)
    end
  end
end
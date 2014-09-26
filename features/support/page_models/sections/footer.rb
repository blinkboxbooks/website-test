module PageModels
  class FooterLinks < PageModels::BlinkboxbooksSection
    element :about_blinkbox_books, "a[data-test='footer-about-link']"
    element :help, "a[data-test='footer-help-link']"
    element :terms_and_conditions, "a[data-test='footer-t-and-c-link']"
    element :blinkbox_movies, "a[data-test='footer-movies-link']"
    element :blinkbox_music, "a[data-test='footer-music-link']"
    element :blinkbox_blogs, "a[data-test='footer-blog-link']"
    element :blinkbox_careers, "a[data-test='footer-careers-link']"
  end

  class FooterSteps < PageModels::BlinkboxbooksSection
    element :title_element, 'h2'
    element :image, 'img'

    def title
      wait_for_title_element
      title_element.text
    end
  end

  class Footer < PageModels::BlinkboxbooksSection
    element :version_div, 'div.versionInfo', visible: false
    elements :top_authors, 'div#footer_authors1 ul.lists li a'
    elements :top_categories, 'div#footer_categories ul.lists li a'
    elements :new_releases, 'div#footer_releases ul.lists li a[bo-text]'
    section :links, FooterLinks, 'div#bottom_footer'
    sections :steps, FooterSteps, 'ul#steps li'

    def version_info
      version_div.text(:all)
    end

    def author_by_name(name)
      top_authors.find { |i| i.text == name }
    end

    def category_by_name(name)
      top_categories.find { |i| i.text == name }
    end

    def step_by_title(title)
      steps.find { |i| i.title == title }
    end

    def navigate_by_link(link_name)
      link = link_name.downcase.gsub(' ', '_').gsub('&', 'and')
      if links.respond_to?(link)
        links.send(link).click
      else
        raise "Not recognised footer navigation link: #{link}"
      end
    end
  end
end
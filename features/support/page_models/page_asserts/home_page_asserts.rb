module PageModels
  module HomePageAsserts
    def assert_homepage_banner_displayed
      expect(home_page.banner).to be_visible
    end

    def assert_homepage_banner_images(min_banners, max_banners)
      expect(home_page.banner.slides.count).to be_between(min_banners, max_banners)
      home_page.banner.images.each { |image| expect(image).to be_visible }
    end

    def assert_homepage_banner_navigation(min_banners, max_banners)
      expect(home_page.banner.slide_numbers.count).to be_between(min_banners, max_banners)
    end

    def assert_promotable_category(category_name, no_of_books)
      category_name.include?('Spotlight') ? @category_section = home_page.spotlight_on_category : @category_section = home_page.highlights_category
      expect(@category_section.books).to have(no_of_books.to_i).items
    end

    def assert_all_books_displayed
      expect(@category_section.invisible_books).to have(0).items
    end
  end
end
World(PageModels::HomePageAsserts)
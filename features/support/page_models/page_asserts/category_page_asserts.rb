module PageModels
  module CategoryPageAsserts
    def assert_category_page_displayed(category_name)
      expect(category_page).to be_displayed
      title = category_name.downcase.gsub(/&|'|and|,/, '').gsub(/ +/, '-')
      expect(category_page.current_url).to include(title)
    end

    def assert_number_of_categories(expected_top_categories)
      expect(categories_page.top_categories).to have_exactly(expected_top_categories.to_i).items
    end

    def assert_category_displayed(category_id)
      expect(categories_page).to have_category(category_id)
    end

    def assert_category_title(category_id, category_name)
      expect(categories_page.category_by_id(category_id).title).to eq(category_name)
    end

    def assert_category_image_displayed(category_id)
      category = categories_page.category_by_id(category_id)
      expect(category.cover_image).to be_visible
    end

    def assert_category_not_displayed(category_id)
      expect(categories_page).to_not have_category(category_id)
    end

    def assert_categories_list
      expect(categories_page).to have_top_categories
      categories_page.top_categories.each { |category_box| expect(category_box).to have_no_cover_image }
    end
  end
end
World(PageModels::CategoryPageAsserts)
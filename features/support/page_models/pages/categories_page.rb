module PageModels
  class CategoriesPage < PageModels::BlinkboxbooksPage
    set_url '/#!/categories'
    set_url_matcher /categories/

    element :all_categories_list, '[data-test="all-categories-list"]'
    elements :categories, 'div.category div.cover a img'
    elements :category_titles, 'div.category div.title'
    sections :book_results_sections, BookResults, '[data-test="search-results-list"]'

    sections :top_categories, CategoryBox, '[data-test="recommended-category-container"] li'
    sections :all_categories, CategoryBox, '[data-test="all-categories-container"] li'

    def category_by_id(id)
      all_categories.find { |category| category.id == id }
    end

    def has_category?(category_id)
      !!categories_page.category_by_id(category_id)
    end

    # TODO: Everything below must be refactored, using the top_categories, all_categories sections!

    def category_by_index(index)
      raise "Cannot find category with index #{index}" if categories[index].nil?
      categories[index]
    end

    def title_for_category(index)
      category_titles[index].text
    end

    def select_category_by_index(index = random_category_index)
      wait_until_categories_visible(10)
      category_title = title_for_category index
      puts "Selecting category #{category_title}"
      category_by_index(index).click
      category_title
    end

    def random_category_index
      wait_until_all_categories_list_visible(10)
      rand(0...categories.count)
    end

    def top_categories_titles
      wait_for_top_categories
      categories = []
      top_categories.each { |category| categories << category.title }
      categories
    end

  end
  register_model_caller_method(CategoriesPage)
end
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
      !!category_by_id(category_id)
    end

    def select_random_category
      wait_until_all_categories_visible(10)
      category = all_categories.sample
      category_title = category.title
      puts "Selecting category #{category_title}"
      category.click
      category_title
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
module PageModels
  class CategoriesPage < PageModels::BlinkboxbooksPage
    set_url "/#!/categories"
    set_url_matcher /categories/
    element :all_categories_list, '[data-test="all-categories-list"]'
    elements :categories, 'div.category div.cover a img'

    def category_by_index(index)
      raise "Cannot find category with index #{index}" if categories[index].nil?
      categories[index]
    end

    def select_category(index)
      wait_until_all_categories_list_visible
      category_by_index(index).click
    end
  end



  register_model_caller_method(CategoriesPage)
end
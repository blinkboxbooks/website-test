module PageModels
  class CategoryPage < PageModels::BlinkboxbooksPage
    set_url '/#!/category/{name}'
    set_url_matcher /category/

    sections :book_results_sections, BookResults,'[data-test="search-results-list"]'
    element :category_name, '[data-test="category-title"]'

    def show?(category_name)
      category_url = category_name.downcase.gsub(/[&',]|and/, '').gsub(/ +/, '-')
      current_url.include?(category_url)
    end
  end

  register_model_caller_method(CategoryPage)
end
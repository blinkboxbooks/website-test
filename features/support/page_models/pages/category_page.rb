module PageModels
  class CategoryPage < PageModels::BlinkboxbooksPage
    set_url "/#!/category"
    set_url_matcher /category/
  end

  register_model_caller_method(CategoryPage)
end
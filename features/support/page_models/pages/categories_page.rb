module PageModels
  class CategoriesPage < PageModels::BlinkboxbooksPage
    set_url "/#!/categories"
    set_url_matcher /categories/
  end

  register_model_caller_method(CategoriesPage)
end
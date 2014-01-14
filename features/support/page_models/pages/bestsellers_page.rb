module PageModels
  class BestsellersPage < PageModels::BlinkboxbooksPage
    set_url "/#!/bestsellers"
    set_url_matcher /bestsellers/

    element :list_view, '.list-view'
    element :grid_view, '.grid-view'
  end

  register_model_caller_method(BestsellersPage)
end
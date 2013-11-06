module PageModels
  class BestSellersPage < PageModels::BlinkboxbooksPage
    set_url "/#!/bestsellers"
    set_url_matcher /bestsellers/
  end

  register_model_caller_method(BestSellersPage)
end
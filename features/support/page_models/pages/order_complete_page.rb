module PageModels
  class OrderCompletePage < PageModels::BlinkboxbooksPage
    set_url_matcher /order-complete/

    def navigation_timeout
      15
    end
  end

  register_model_caller_method(OrderCompletePage, :order_complete_page)
end
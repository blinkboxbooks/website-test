module PageModels
  class OrderCompletePage < PageModels::BlinkboxbooksPage
    set_url_matcher /order-complete/
    set_url '/#!/order-complete{?book}{&cpa}'

    element :continue_shopping_button,     'a', :text => /Continue shopping/i
    element :read_your_book_now_button, 'button', :text => /Read your book now/i
    element :order_complete_message, '#order-complete'
  end

  register_model_caller_method(OrderCompletePage, :order_complete_page)
end
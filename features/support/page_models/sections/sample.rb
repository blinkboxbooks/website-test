module PageModels
  class Sample < PageModels::BlinkboxbooksSection
    element :remove_sample, '[data-test="remove-sample-link"]'
    element :view_sample, '[data-test="view-sample-link"]'
    element :buy_button, 'button[data-test="book-buy-button"]'
    element :book_title, '[data-test="book-title"]'
    element :book_price, '[data-test="book-price"]'
  end
end

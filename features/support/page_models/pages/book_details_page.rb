module PageModels
  class BookDetailsPage < PageModels::BlinkboxbooksPage
    set_url_matcher /book/
    element :read_offline, ".read-offline"
    element :buy_now, 'button[data-test="book-buy-button"]'
    element :cover, '#cover'
    element :details_area, '.details'
    element :description, '#description'
    section :reader, Reader, 'div#individual-book'

  end
  register_model_caller_method(BookDetailsPage)
end
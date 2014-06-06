module PageModels
  class BookDetailsPage < PageModels::BlinkboxbooksPage
    set_url_matcher /book/
    set_url "/#!/book/{isbn}/{title}"
    element :read_offline, ".read-offline"
    element :buy_now, 'button[data-test="book-buy-button"]'
    element :cover, '#cover'
    element :details_area, '.details'
    element :description, '#description'
    section :reader, Reader, 'div#individual-book'
    element :title_element, '#book-details h1'

    def title
      title_element.text
    end
  end
  register_model_caller_method(BookDetailsPage)
end
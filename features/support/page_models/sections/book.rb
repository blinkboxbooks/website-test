module PageModels
  class Book < PageModels::BlinkboxbooksSection

    element :layer, 'div.book'
    element :title_element, 'h2.title'
    element :author, 'div.author'
    element :price_element, 'span[data-test="book-price"]'
    element :discount_price_element, 'span[data-test="book-price"] span.discount'
    element :cover_image, 'div.cover'
    element :buy_now_button, '[data-test="book-buy-button"]'
    element :book_details_button, '[data-test="book-details-button"]'
    element :isbn_element, 'div.details'

    def free?
      wait_for_price_element
      price_element.text.downcase.eql?("Free".downcase)
    end

    def purchasable?
      published? && !free? && price > 0.0
    end

    def price
      if has_discount_price_element?
        book_price = discount_price_element.text
      elsif has_price_element?
        book_price = price_element.text
      else
        book_price = 0
        puts "Book '#{title.text}' has no price information displayed!"
      end
      book_price.gsub(/£/, '').to_f
    end

    def isbn
      isbn_element.scan(/[0-9]+/)[0]
    end

    def title
      wait_for_title_element
      title_element.text
    end

    def publication_date
      DateTime.parse(layer['data-test'].scan(/[0-9]{4}\-[0-9]{2}\-[0-9]{2}/)[0])
    end

    def published?
      publication_date <= DateTime.now
    end

    def click_buy_now
      mouse_over(cover_image)
      wait_for_buy_now_button
      wait_until_buy_now_button_visible
      buy_now_button.click
    end

    def click_view_details
      mouse_over(cover_image)
      wait_for_book_details_button
      wait_until_book_details_button_visible
      book_details_button.click
    end
  end
end
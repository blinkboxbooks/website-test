module PageModels
  class Book < PageModels::BlinkboxbooksSection

    element :layer, 'div.book'
    element :title, 'h2.title'
    element :author, 'div.author'
    element :price, 'span[data-test="book-price"]'
    element :discount_price, '.discount'
    element :cover_image, 'div.cover'
    element :buy_now_button, '[data-test="book-buy-button"]'
    element :book_details_button, '[data-test="book-details-button"]'
    element :data_isbn, 'div.details'

    def free?
      price.text.downcase.eql?("Free".downcase)
    end

    def has_price?
      wait_for_price
      if price.text.include?("£")
        true
      else
        puts "Book '#{title}' has no price information displayed!"
        false
      end
    end

    def isbn
      data_isbn.scan(/[0-9]+/)[0]
    end

    def publication_date
      DateTime.parse(layer['data-test'].scan(/[0-9]{4}\-[0-9]{2}\-[0-9]{2}/)[0])
    end

    def published?
      publication_date <= DateTime.now
    end

    def click_buy_now()

      cover_image.hover
      wait_for_buy_now_button
      buy_now_button.click
    end

    def click_details_button()
      cover_image.hover
      wait_for_book_details_button
      book_details_button.click
    end

    def get_book_price
      if has_discount_price?
        book_price = discount_price.text
      elsif has_price?
        book_price = price.text
      else
        book_price = 0
        puts "Book '#{title}' has no price information displayed!"
      end
      return book_price.gsub(/£/, '').to_f
    end
  end
end
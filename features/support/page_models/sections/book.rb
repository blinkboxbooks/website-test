module PageModels
  class Book < PageModels::BlinkboxbooksSection
    element :layer, 'div.book'
    element :title_element, 'h2.title'
    element :title_element_list, 'h2.title a'
    element :author_element, '[data-test^="book-authors"]', :match => :first
    element :price_element, 'span[data-test="book-price"]'
    element :discount_price_element, 'span[data-test="book-price"] span.discount'
    element :cover_image, 'div.cover'
    element :buy_now_button, '[data-test="book-buy-button"]'
    element :book_details_button, '[data-test="book-details-button"]'
    element :isbn_element, 'div.details'
    element :cover_link, '[data-test="book-title-cover"]'

    # List View elements
    element :clubcard_points, '[data-test="book-clubcard-points"]'
    element :clubcard_logo, '.club_card_logo img'

    def free?
      wait_for_price_element
      has_price_element? && price_element.text.downcase.eql?('free')
    rescue e
      puts "Warning: Book '#{self.isbn}' doesn't have price or text 'free' displayed (possibly a caching issue).\n \n#{e.message}"
      false
    end

    def purchasable?
      published? && !free? && price > 0.0
    end

    def price
      if has_discount_price_element?
        wait_for_discount_price_element
        book_price = discount_price_element.text
      elsif has_price_element?
        wait_for_price_element
        book_price = price_element.text
      else
        book_price = 0
        puts "Book '#{title}' has no price information displayed!"
      end
      book_price.to_s.gsub(/£/, '').to_f
    end

    def isbn
      isbn_element['data-test'].scan(/[0-9]+/)[0]
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
      if parent.parent.current_view == :grid
        mouse_over(cover_image)
        wait_for_book_details_button
        wait_until_book_details_button_visible
        book_details_button.click
      else
        wait_for_title_element_list
        wait_until_title_element_list_visible
        title_element_list.click
      end
    end

    def book_details_url
      cover_link[:href]
    end

    def author
      # Some book does not have author associated to it
      # ex. https://nodejs-internal.mobcastdev.com/#!/book/9780307554468/at-fenway?q=dan%20brown
      has_author_element? ? author_element[:title] : ''
    end
  end
end

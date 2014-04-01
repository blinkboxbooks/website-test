#TODO: convert books into section: sections books. :title, :publication_date, preice, button etc becomes elements inside each book section

module PageModels
  class BookResults < PageModels::BlinkboxbooksSection

    elements :books, "div[book=\"book\"]"
    element :buy_now_button, '[data-test="book-buy-button"]'
    element :book_details_button, '[data-test="book-details-button"]'
    elements :book_price, 'div.price', :visible => false

    private
    def book_by_index(index)
      raise "Cannot find book with index #{index}" if books[index].nil?
      books[index]
    end

    def free_book?(book)
      book.find('[class="price"]').text.downcase.eql?("Free".downcase)
    end

    def book_has_price?(index)
      wait_for_book_price
      if !book_price[index].text.eql?("")
        return true
      else
        puts "book #{books[index].text} has no price information displayed, selecting another book. Check with services."
        return false
      end
    end

    def book_published?(index)
      data_test = book_by_index(index).find("div.book")['data-test']
      publish_date = DateTime.parse(data_test.scan(/[0-9]{4}\-[0-9]{2}\-[0-9]{2}/)[0])
      publish_date <= DateTime.now
    end

    def click_buy_now(book)
      book.hover
      wait_for_buy_now_button
      buy_now_button.click
    end

    def title_for_book(index)
      wait_for_books
      book_by_index(index).find('[class="title"]').text
    end

    def get_book_price(book)
      within book do
        if page.has_selector?(:css, '.discount')
          book_price = book.find('[class="discount"]').text
        else
          book_price = book.find('[class="price"]').text
        end
        return book_price.gsub(/£/, '').to_f
      end
    end

    public
    def click_buy_now_for_book(index = random_book_index)
      book_title = title_for_book(index)
      puts "Selecting book with title #{book_title} to buy"
      click_buy_now (book_by_index(index))
      return book_title
    end

    def click_book_details_for_book(index = random_book_index)
      book_title = title_for_book(index)
      book_by_index(index).find('img').click
      return book_title
    end

    def random_book_index
      # TODO: This code is messy
      wait_for_books
      index = 0
      found = false
      (0..99).each do |i|
        index = rand(0...books.count)
        if book_has_price?(index) && book_published?(index)
          found = true
          break
        end
      end
      raise 'Cannot find a purchasable book!' unless found
      return index
    end

    def buy_now_book_price_less_than (book_price)
      books.each do |book|
        next if free_book?(book)
        price = get_book_price(book)
        if (price < book_price.to_f)
          puts "Buying book with price  #{price}"
          click_buy_now(book)
          return price
        end
      end
    end

    def buy_now_book_price_more_than (book_price)
      books.each do |book|
        next if free_book? book
        price = get_book_price book
        if (price > book_price.to_f)
          click_buy_now(book)
          return price
        end
      end
    end

  end
end


##Unfinished
#module PageModels
#  class BookItems < PageModels::BlinkboxbooksSection
#    def self.root_node
#      "div.itemsets"
#    end
#
#    include Enumerable
#    elements :item_nodes, "div[book=\"book\"]"
#
#    def items
#      #lazy_initialization & cache_lookup
#      @items = parse_items if (@items.nil? || @items.empty?)
#      @items
#    end
#
#    # Parse book items on the page or section
#    def parse_items
#      items = []
#      self.item_nodes.each do |node|
#        #get substring of the book text content, without numbers and currency symbol
#        text = node.text[/[\w\s\-\']{1,}/]
#        items << BookItem.new(self, self.first("div[book=\"book\"]", :text => text))
#      end
#      @items = items
#    end
#
#    #Helper methods to operate with the collection of results
#
#    def random_item
#      items[rand(self.size)]
#    end
#
#    def size
#      items.size
#    end
#
#    alias :length :size
#
#    def each(& block)
#      items.each(& block)
#    end
#
#    def [](index)
#      items[index.to_i]
#    end
#
#  end
#
#  class BookItem < PageModels::BlinkboxbooksSection
#  end
#
#  def book_items
#    @_book_items ||= BookItems.new(current_page, BookItems.root_node)
#  end
#end
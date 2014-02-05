module PageModels
  class BookResults < PageModels::BlinkboxbooksSection

    elements :books, "div[book=\"book\"]"
    element :buy_now_button, '[data-test="book-buy-button"]'
    element :book_details_button, '[data-test="book-details-button"]'

    private
    def book_by_index(index)
      raise "Cannot find book with index #{index}" if books[index].nil?
      books[index]
    end

    public
    def click_buy_now_for_book(index)
      wait_until_books_visible
      page.driver.browser.action.move_to(book_by_index(index).native).perform
      buy_now_button.click
    end

    def click_book_details_for_book(index)
      wait_until_books_visible
      page.driver.browser.action.move_to(book_by_index(index).native).perform
      book_details_button.click
    end

    def title_for_book(index)
      wait_until_books_visible
      book_by_index(index).find('[class="title"]').text
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
#    #TODO: add internal elements such as Book Details and Buy Now buttons, price, title, index

#  end
#
#  def book_items
#    @_book_items ||= BookItems.new(current_page, BookItems.root_node)
#  end
#end
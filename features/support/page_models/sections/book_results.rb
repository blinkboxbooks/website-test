#Unfinished
module PageModels
  class BookItems < PageModels::BlinkboxbooksSection
    def self.root_node
      "div.itemsets"
    end

    include Enumerable
    elements :item_nodes, "div[book=\"book\"]"

    def items
      #lazy_initialization & cache_lookup
      @items = parse_items if (@items.nil? || @items.empty?)
      @items
    end

    # Parse book items on the page or section
    def parse_items
      items = []
      self.item_nodes.each do |node|
        #get substring of the book text content, without numbers and currency symbol
        text = node.text[/[\w\s\-\']{1,}/]
        items << BookItem.new(self, self.first("div[book=\"book\"]", :text => text))
      end
      @items = items
    end

    #Helper methods to operate with the collection of results

    def random_item
      items[rand(self.size)]
    end

    def size
      items.size
    end

    alias :length :size

    def each(& block)
      items.each(& block)
    end

    def [](index)
      items[index.to_i]
    end

  end

  class BookItem < PageModels::BlinkboxbooksSection
    #TODO: add internal elements such as Book Details and Buy Now buttons, price, title, index
  end

  def book_items
    @_book_items ||= BookItems.new(current_page, BookItems.root_node)
  end
end
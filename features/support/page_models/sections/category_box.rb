module PageModels
  class CategoryBox < PageModels::BlinkboxbooksSection
    element :cover, 'div.cover a'
    element :title_element, 'div.title'
    element :category_div, 'div[data-category="category"]'

    def title
      title_element.text
    end

    def displayed?
      root_element.visible?
    end

    def id
      category_div['data-test'][/\d+/]
    end

    def click
      cover.click
    end
  end
end

module PageModels
  class CategoryBox < PageModels::BlinkboxbooksSection
    element :cover_image, 'div.cover img'
    element :title_element, 'div.title'
    element :category_div, 'div[data-category="category"]'

    def title
      title_element.text
    end

    def displayed?
      root_element.visible?
    end

    def id
      category_div['data-test'].match(/\d+/)[0]
    end
  end
end
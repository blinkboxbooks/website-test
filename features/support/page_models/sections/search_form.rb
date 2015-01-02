module PageModels
  class SearchForm < PageModels::BlinkboxbooksSection
    element :keyword_element, 'input[data-test="search-input"]'
    element :search_button, 'button[data-test="search-button"]'
    element :icon_remove, 'i.icon-remove'
    elements :suggestions, 'ul#suggestions li'

    def keyword
      keyword_element[:value]
    end

    def set_keyword(keyword)
      keyword_element.set keyword
    end

    def suggestion(text)
      suggestions.find { |li| li.text == text }
    end

    def select_suggestion(text)
      result = suggestion(text)
      raise "Unable to find suggestion by text '#{text}'" if result.nil?
      result.find('a').click
    end
  end
end

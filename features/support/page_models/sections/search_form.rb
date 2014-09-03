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

    def click_on_suggestion(search_word)
      suggestions.find('a').find{|suggestion|suggestion.text==search_word}.click
    end
  end
end
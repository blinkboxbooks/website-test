module PageModels
  class SearchForm < PageModels::BlinkboxbooksSection
    element :keyword, 'input[data-test="search-input"]'
    element :search_button, 'button[data-test="search-button"]'
    element :icon_remove, 'i.icon-remove'
    elements :suggestions, 'ul#suggestions li'
  end
end
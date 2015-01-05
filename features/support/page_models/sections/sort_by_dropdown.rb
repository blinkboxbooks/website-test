module PageModels
  class SortByDropdown < PageModels::BlinkboxbooksSection
    elements :list, 'ul li'
    element :selected_item_element, '.item a'

    def selected_item
      selected_item_element.text.match(/:(.+)/)[1].lstrip
    end

    def select_item(title)
      selected_item_element.hover
      wait_until_list_visible
      item = list.find { |l| l.text == title }
      fail "Sort by \"#{title}\" option does not exist!" if item.nil?
      item.hover
      item.click
    end
  end
end

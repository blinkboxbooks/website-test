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
      item = list.find { |item| item.text == title }
      unless item.nil?
        item.hover
        item.click
      else
        raise "Sort by \"#{title}\" option does not exists!"
      end
    end
  end
end
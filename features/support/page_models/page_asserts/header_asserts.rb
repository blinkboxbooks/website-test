module PageModels
  module HeaderAsserts

    def assert_header_tabs_not_selected
      current_page.header.links.each { |link| expect(link[:class]).to_not include('current') }
    end

  end
end
World(PageModels::HeaderAsserts)
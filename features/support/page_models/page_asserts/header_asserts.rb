module PageModels
  module HeaderAsserts

    def assert_header_tabs_not_selected
      expect(current_page.header.selected_tab).to be_nil
    end

  end
end
World(PageModels::HeaderAsserts)
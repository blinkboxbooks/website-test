module PageModels
  module FooterActions

    def click_author_link_on_footer(author_name)
      link = current_page.footer.author_by_name(author_name)
      !link.nil? ? link.click : raise("Unable to find an author by name #{author_name}")
    end

    def click_category_link_on_footer(category_name)
      link = current_page.footer.category_by_name(category_name)
      !link.nil? ? link.click : raise("Unable to find category by name #{category_name}")
    end

    def click_footer_link(link_name)
      current_page.footer.navigate_by_link(link_name)
    end

  end
end

World(PageModels::FooterActions)
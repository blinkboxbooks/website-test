def click_navigation_link(page_name)
  case page_name.downcase
    when 'featured'
      current_page.header.navigation.featured.click
    when 'categories'
      current_page.header.navigation.categories.click
    when 'bestsellers'
      current_page.header.navigation.bestsellers.click
    when 'new releases'
      current_page.header.navigation.new_releases.click
    when 'free ebooks'
      current_page.header.navigation.free_ebooks.click
    when 'authors'
      current_page.header.navigation.authors.click
  end
end
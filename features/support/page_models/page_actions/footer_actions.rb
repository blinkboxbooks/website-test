def click_author_link_on_footer(author_name)
  current_page.footer.top_authors.each do |author|
    if author.text == author_name
      author.find('a').click
      break
    end
  end
end

def click_category_link_on_footer(category_name)
  current_page.footer.top_categories.each do |category|
    if category.text == category_name
      category.find('a').click
      break
    end
  end
end

def click_footer_link(link_name)
  case link_name.downcase
    when 'about blinkbox books'
      current_page.footer.links.about_blinkbox.click
    when 'terms & conditions'
      current_page.footer.links.terms_and_conditions.click
    when 'about blinkbox books'
      current_page.footer.links.about_blinkbox.click
    when 'about blinkbox books'
      current_page.footer.links.about_blinkbox.click
    when 'about blinkbox books'
      current_page.footer.links.about_blinkbox.click
  end
end
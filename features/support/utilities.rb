def find_a_text selector,type
  within(selector) do
    case type
      when 'author'
        within(find('[data-test="book-authors"]')) do
          @actual_text = find('a')[:text]
        end
      when 'title'
          @actual_text= find('[data-test="book-title"]')[:title]
    end
  end
  return @actual_text
end


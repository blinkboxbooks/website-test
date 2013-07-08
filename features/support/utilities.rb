def find_a_text selector,type
  within(selector) do
    case type
      when 'author'
        @actual_text = find('[data-test="book-authors"]')[:title]

      when 'title'
          @actual_text= find('[data-test="book-title"]')[:title]
    end
  end
  return @actual_text
end


module ReaderActions

  def read_sample_book
    first_page = get_reader_page_contents
    click_reader_next_page
    click_reader_next_page
    click_reader_next_page
    another_page = get_reader_page_contents
    expect(first_page).to_not eq(another_page)
  end

  def click_reader_next_page
    book_details_page.reader.turn_to_the_next_page
  end

  def get_reader_page_contents
    book_details_page.reader.page.text
  end
end

World(ReaderActions)
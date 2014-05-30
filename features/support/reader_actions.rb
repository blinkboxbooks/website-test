module ReaderActions

  def read_sample_book
    first_page = get_reader_page_contents
    click_reader_next_page
    click_reader_next_page
    click_reader_next_page
    another_page = get_reader_page_contents
    expect(another_page).to_not eq(first_page)
  end

  def click_reader_next_page
    within('#individual-book') do
      find('[class="right-arrow"]').click
    end
  end

  def get_reader_page_contents
    within('#reader_container') do
      page_text = page.text
      return page_text
    end
  end
end

World(ReaderActions)
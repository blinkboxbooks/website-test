require 'capybara/dsl'
require 'capybara/rspec/matchers'
require 'capybara/selenium/node'


def assert_search_results  search_word
  page.should have_content("You searched for \"#{search_word}\"")
  find('[data-test="list-button"]').visible?
  within("div.item")  do
    find('[data-test="expand-list-button"]').visible?
  end

end


def assert_author_name author_name
  selector =  'li.grid-5:nth-child(1)'
  ((find_a_text selector,'author').downcase).should == (author_name).downcase
end

def assert_title book_title
  selector = 'li.grid-5:nth-child(1)'
  ((find_a_text selector,'title').downcase).should == (book_title).downcase
end


def assert_unique_result
  within(".grid") do
    page.should have_css("li", :count => 1)
  end
end


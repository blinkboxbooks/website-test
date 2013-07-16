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

def assert_number_of_suggestions number_of_suggestion
  within("#suggestions")do
    page.all("li").count.should >= number_of_suggestion
  end
end

def assert_auto_corrected_word corrected_word
 within("#suggestions") do
    i = 0
    page.all('li').to_a.each do |li|
      li.text.should == corrected_word[i]
      i += 1
    end
  end
end


def assert_search_word_in_suggestions search_word
  within("#suggestions") do
    page.all('li').to_a.each do |li|
    ((li.text).include?(search_word)).should == true
    end
  end
end

def assert_last_suggestion search_word
  within("#suggestions") do
    ((page.all('li').to_a.last).text).should == search_word
  end
end

def is_category_displayed category_id
  category_displayed=false
  within('[data-test="all-categories-list"]') do
    page.all('li').to_a.each do |li|
      begin
        if ((li.find('[data-category="category"]')['data-test']).include?(category_id) == true)
           category_displayed = true;
        end
      rescue TypeError => e
        e.message
        category_displayed = false;
      end
    end
    end
 return category_displayed
end

def find_category category_id
 within('[data-test="all-categories-list"]') do
  page.all('li').to_a.each do |li|
      if (li.find('[data-category="category"]')['data-test']).include?(category_id) == true
       return li.find('[data-category="category"]')['data-test'];
      end
  end
 end

end







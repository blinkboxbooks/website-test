require 'capybara/dsl'
require 'capybara/rspec/matchers'
require 'capybara/selenium/node'


def assert_search_results  search_word
  page.should have_content("You searched for \"#{search_word}\"")
  page.find('[data-test="search-results-list"]').visible?
  within('[data-test="search-results-list"]')  do
    page.all('li',:visible =>false).count.should >= 1
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

def assert_main_footer_displayed
  (find('[data-test="footer-container"]').visible?).should == true
end

def assert_footer_section(section)
  case section
    when 'Connect with us'
      (find('[data-test="footer-connect-with-us-container"]').visible?).should == true
    when 'New releases'
      (find('[data-test="footer-new-releases-container"]').visible?).should == true
    when 'Top authors in crime'
      (find('[data-test="footer-top-authors-in-crime-container"]').visible?).should == true
    when 'Top authors'
      (find('[data-test="footer-top-authors-container"]').visible?).should == true
  end
end

def assert_social_media_links
  within('[data-test="footer-connect-with-us-container"]') do
    (find('[data-test="footer-facebook-link"]').visible?).should == true
    (find('[data-test="footer-twitter-link"]').visible?).should == true
    (find('[data-test="footer-pintrest-link"]').visible?).should == true
  end
end

def assert_section_header(section_id,text)
  within("[data-test='#{section_id}']") do
    page.text.include?(text).should == true
  end
  #(page.find("[class='#{section_id}']").text).should == text
end

def assert_page_path(page_name)
  case page_name
    when "Categories"
      current_path.should.eql?('/#!/categories/') == true
    when "Best sellers"
      current_path.should.eql?('#!/bestsellers/') == true
    when "New releases"
      current_path.should.eql?('/#!/new') == true
    when "Top free"
      current_path.should.eql?('#!/topfree/') == true
    when "Authors"
      current_path.should.eql?('#!/authors/') == true
    when "Terms and conditions"
      current_path.should.eql?('#!/terms_and_conditions') == true
  end
end

def assert_container (section_id)
  (page.find("[data-test='#{section_id}']").visible?).should == true
end









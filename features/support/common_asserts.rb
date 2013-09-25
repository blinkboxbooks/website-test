require 'capybara/dsl'
require 'capybara/rspec/matchers'
require 'capybara/selenium/node'

module AssertNavigation
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
    find('[data-test="footer-container"]').should be_visible
  end

  def assert_footer_section(section)
    case section
      when 'Connect with us'
        find('[data-test="footer-connect-with-us-container"]').should be_visible
      when 'New releases'
        find('[data-test="footer-new-releases-container"]').should be_visible
      when 'Top authors in crime'
        find('[data-test="footer-top-authors-in-crime-container"]').should be_visible
      when 'Top authors'
        find('[data-test="footer-top-authors-container"]').should be_visible
    end
  end

  def assert_social_media_links
    within("[data-test='#{get_element_id_for("Connect with us container")}']") do
      find("[data-test='#{get_element_id_for("Facebook")}']").should be_visible
      find("[data-test='#{get_element_id_for("Twitter")}']").should be_visible
      find("[data-test='#{get_element_id_for("Pintrest")}']").should be_visible
    end
  end

  def assert_section_header(section_id,text)
    within("[data-test='#{section_id}']") do
      page.text.should include(text)
    end
  end

  def assert_page_path(page_name)
    current_path.should.eql?("#{get_page_url_path_for("#{page_name}")}") == true
  end

  def assert_container (section_id)
    page.find("[data-test='#{section_id}']").should be_visible
  end

  def assert_book_details
    find('[id="cover"]').should be_visible
    find('[class="details"]').should be_visible
    find('[id="description"]').should be_visible
    find('[id="sample"]').should be_visible
    find('[id="individual-book"]').should be_visible

  end

end
 World(AssertNavigation)


module AssertSearch
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

end

World(AssertSearch)

module AssertMyAccount
  def assert_tab_selected(tab_name)
    case tab_name
      when 'Order & payment'
        find('[class = "account_menu_first hide_tablet selected"]').should be_visible
      when 'Your personal details'
        find('[class = "hide_tablet selected"]').should be_visible
      when 'Your payments'
        find('[class = "hide_tablet selected"]').should be_visible
      when 'Your devices'
        find('[class = "account_menu_last show_tablet selected"]').should be_visible
    end
  end
end










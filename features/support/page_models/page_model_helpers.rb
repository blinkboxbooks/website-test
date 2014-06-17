module PageModelHelpers
  include WebUtilities

  def class_name_to_caller_method(class_name)
    class_name.to_s.gsub(/.*::([^:]*)/, '\1').camel_case_to_underscore_case
  end

  def page_class_name_to_caller_method(class_name)
    class_name_to_caller_method(class_name).sub(/_page$/, '') + '_page'
  end

  #example: HomePage --> home_page
  # def home_page
  #    @_home_page ||= HomePage.new
  # end
  def register_model_caller_method(class_name, caller_method=nil)
    caller_method ||= page_class_name_to_caller_method(class_name)
    class_eval %Q{def #{caller_method}
                    @_#{caller_method} ||= #{class_name}.new
                  end}
  end

  # Determine page class name based on page name
  #
  # @param [String] page_name                 page name in plain text. possible page name in the step: AllInclusive, All-Inclusive, All Inclusive, AllInclusivePage, All-Inclusive Page, All Inclusive Page
  # @return [PageModels::BlinkboxbooksPage]   page class or raises an exception if not found. possible class name options: AllInclusive, AllInclusivePage.
  def page_model(page_name)
    page_class = page_name.to_class_name
    unless PageModels.const_defined?(page_class)
      page_class << 'Page'
      unless PageModels.const_defined?(page_class)
        #raise "Page is not registered as a Blinkboxbooks page model: '#{page_name}'"
        return nil
      end
    end
    PageModels.const_get("#{page_class}").new
  end

  # Additional timeout exceptions for page models
  class TimeOutWaitingForPageToAppear < StandardError; end
  class TimeOutWaitingForPageToDisappear < StandardError; end
end

module PageModels
  extend PageModelHelpers
  include PageModelHelpers
end

World(PageModels)
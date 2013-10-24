module PageModelHelpers
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
end

module PageModels
  extend PageModelHelpers
end

World(PageModels)
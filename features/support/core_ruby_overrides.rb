class String
  #example: "MyFirstClass" --> "my_first_class"
  def camel_case_to_underscore_case
    to_s.gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').
        gsub(/([a-z\d])([A-Z])/, '\1_\2').
        tr('-', '_').
        downcase
  end

  #example: "home page" --> "HomePage"
  def to_class_name
    to_s.gsub('&', 'and').gsub(/[\- ]/, '_').camelize(:upper)
  end

  def titlecase_to_underscore_case
    to_s.downcase.gsub(' ', '_')
  end
end
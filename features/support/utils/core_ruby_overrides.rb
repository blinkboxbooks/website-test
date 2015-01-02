class String
  #example: "home page" --> "HomePage"
  def to_class_name
    to_s.gsub('&', 'and').gsub(/[\- ]/, '_').camelize(:upper)
  end

  def titlecase_to_underscore_case
    to_s.downcase.gsub(' ', '_')
  end
end

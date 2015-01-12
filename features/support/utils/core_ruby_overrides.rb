class String
  #example: "home page" --> "HomePage"
  def to_class_name
    gsub('&', 'and').gsub(/[\- ]/, '_').camelize(:upper)
  end

  def titlecase_to_underscore_case
    downcase.gsub(' ', '_')
  end
end

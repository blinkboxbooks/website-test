require 'yaml'

module TestData

  def load_yaml_file
    path = File.join(File.dirname(__FILE__), "../../data/test_data.yml")
    YAML.load_file(path)
    rescue ArgumentError => e
      puts "Could not parse YAML: #{e.message}"
  end

  def test_data(data_type, data)
     test_data = load_yaml_file
     test_data[data_type][data]
  end

end

World(TestData)


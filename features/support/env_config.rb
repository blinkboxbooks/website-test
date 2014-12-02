module KnowsAboutTheEnvironment
  def test_data(data_type, param)
    data = test_data_sample(data_type)
    data = data[param.to_s.gsub(' ', '_').downcase]
    fail "Unable to find variable [#{param}] in the test data set of [#{data_type}]" if data.nil?
    data
  end

  def test_data_sample(param)
    initialise_test_data
    data = @@_test_data[param.to_s.gsub(' ', '_').downcase]
    fail "Unable to find variable [#{param}] in the test data" if data.nil?
    if data.respond_to?(:sample)
      data.sample
    else
      data
    end
  end

  def server(server_type = 'web')
    uri = test_env.servers[server_type.to_s.downcase]
    fail "'#{server_type}' server URI is not defined for environment '#{TEST_CONFIG['server']}' in config/environments.yml" if uri.nil?
    uri
  end

  private

  def initialise_test_data
    @@_test_data ||= @data_dependencies[test_env.data.to_s.upcase]
    if @@_test_data.nil?
      fail "Test data '#{test_env.data}' for environment '#{TEST_CONFIG['server']}' is not defined in config/data.yml"
    end
    @@_test_data
  end

  def config_flag_on?(name)
    !!(name.to_s =~ /^on|true$/i)
  end
end

extend KnowsAboutTheEnvironment
include KnowsAboutTheEnvironment
World(KnowsAboutTheEnvironment)

# ======== Load environment specific test data ======
extend KnowsAboutDataDependencies

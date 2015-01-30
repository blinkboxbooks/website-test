module APIMethods
  require 'httpclient'
  require 'multi_json'
  require 'blinkbox/user'
  require_rel 'utilities.rb'

  class Browserstack
    attr_accessor :username
    attr_accessor :key
    attr_accessor :browsers_uri

    def initialize(username, key)
      @username = username
      @key = key
      @browsers_uri = 'https://www.browserstack.com/automate/browsers.json'
      @plan_uri = 'https://www.browserstack.com/automate/plan.json'
      @projects_uri = 'https://www.browserstack.com/automate/projects.json'
    end

    def valid_capabilities?(browser, browser_version, os, os_version)
      !browser_list.select { |b|
        b['browser'] =~ /#{browser}/i &&
        b['browser_version'] =~ /#{browser_version}/i &&
        b['os'] =~ /#{os}/i &&
        b['os_version'] =~ /#{os_version}/i
      }.empty?
    end

    def session_available?
      response = plan_status
      response['parallel_sessions_running'] < response['parallel_sessions_max_allowed']
    end

    def project_exists?(project_name)
      !!project_list.find { |entry| entry['automation_project']['name'] == project_name }
    end

    def http_client
      @http = HTTPClient.new
    end

    def browserstack_api_helper(username, key)
      APIMethods::Browserstack.new(username, key)
    end

    private

    def browser_list
      headers = { 'Authorization' => Base64.strict_encode64("#{@username}:#{@key}"),
                  'Content-Type' => 'application/x-www-form-urlencoded',
                  'Accept' => 'application/json' }
      response = http_client.get(@browsers_uri, body: {}, header: headers)
      fail 'Test Error: Failed to get browsers list from BrowserStack!' unless response.status == 200
      MultiJson.load(response.body)
    end

    def plan_status
      headers = { 'Authorization' => Base64.strict_encode64("#{@username}:#{@key}"),
                  'Content-Type' => 'application/x-www-form-urlencoded',
                  'Accept' => 'application/json' }
      response = http_client.get(@plan_uri, body: {}, header: headers)
      fail 'Test Error: Failed to get number of free sessions from BrowserStack!' unless response.status == 200
      MultiJson.load(response.body)
    end

    def project_list
      headers = { 'Authorization' => Base64.strict_encode64("#{@username}:#{@key}"),
                  'Content-Type' => 'application/x-www-form-urlencoded',
                  'Accept' => 'application/json' }
      response = http_client.get(@projects_uri, body: {}, header: headers)
      fail 'Test Error: Failed to get list of projects from BrowserStack!' unless response.status == 200
      MultiJson.load(response.body)
    end
  end

  class User
    include Utilities

    def initialize(auth, api, braintree_env)
      @auth_uri = auth
      @api_uri = api
      @braintree_env = braintree_env
    end

    def create_new_user!(options = {})
      user_details = {}
      user_details[:username] = options[:email_address] || generate_random_email_address

      client_details = {}
      if options[:with_device]
        client_details[:client_name] = options[:client_name] || 'Web Site Test Client'
        client_details[:client_brand] = options[:client_brand] || 'Tesco'
        client_details[:client_model] = options[:client_model] || 'Hudl'
        client_details[:client_os] = options[:client_os] || 'Android'
      end

      @user = Blinkbox::User.new(user_details.merge(server_uri: @auth_uri, credit_card_service_uri: @api_uri))
      response = @user.register(client_details)
      fail "Creation of a user failed with response: #{response}" unless response.is_a?(Hash)
      response.merge('password' => user_details[:password], 'device_name' => client_details[:client_name])
    end

    def add_credit_card(options = {})
      create_new_user! if @user.nil?
      @card_type = options[:card_type] || 'visa'

      @user.authenticate
      @user.add_default_credit_card(card_type: @card_type, braintree_env: @braintree_env)
    end
  end

  def api_helper
    @api_helper ||= APIMethods::User.new(server('auth'), server('api'), environment_data('braintree_env'))
  end
end
World(APIMethods)

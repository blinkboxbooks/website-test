module APIMethods
  require 'httpclient'
  require 'multi_json'
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

    def initialize(auth, api)
      @auth_uri = "#{auth}/oauth2/token"
      @credit_card_uri = "#{api}/service/my/creditcards"
    end

    def create_new_user!(options = {})
      with_client = options[:with_client]
      @email_address = generate_random_email_address
      @password = 'test1234'
      params = {
        grant_type: 'urn:blinkbox:oauth:grant-type:registration',
        first_name: generate_random_first_name,
        last_name: generate_random_last_name,
        username: @email_address,
        password: @password,
        accepted_terms_and_conditions: true,
        allow_marketing_communications: false
      }
      if with_client
        @device_name = 'Web Site Test Client'
        params.merge!(client_name: @device_name,
                      client_brand: 'Tesco',
                      client_model: 'Hudl',
                      client_os: 'Android')
      end

      headers = { 'Content-Type' => 'application/x-www-form-urlencoded', 'Accept' => 'application/json' }

      #a tmp patch to re-try in case of SSL Broken_pipe failure
      begin
        response = http_client.post(@auth_uri, body: params, header: headers)
      rescue Errno::EPIPE
        response = http_client.post(@auth_uri, body: params, header: headers)
      end

      fail "Test Error: Failed to register new user with response:\n#{response.inspect}" unless response.status <= 201
      user_props = MultiJson.load(response.body)
      @access_token = user_props['access_token']
      [@email_address, @password, @device_name]
    end

    def add_credit_card(access_token = @access_token)
      params = test_data_sample('encrypted_card_details')
      headers = { 'Content-Type' => 'application/vnd.blinkboxbooks.data.v1+json', 'Authorization' => "Bearer #{access_token}" }
      body = { 'type' => 'urn:blinkboxbooks:schema:creditcard' }.merge(params)

      #a tmp patch to re-try in case of SSL Broken_pipe failure
      begin
        response = http_client.post(@credit_card_uri, body: format_body(body), header: headers)
      rescue Errno::EPIPE
        response = http_client.post(@credit_card_uri, body: format_body(body), header: headers)
      end

      fail "Adding credit card failed with response:\n#{response.inspect}" unless response.status <= 201
      params[:cardholderName]
    end

    def http_client
      @http ||= HTTPClient.new
      @http.ssl_config.options |= OpenSSL::SSL::OP_NO_SSLv3
      @http
    end

    def format_body(body)
      if body.is_a?(Hash)
        MultiJson.dump(body)
      else
        body
      end
    end
  end

  def api_helper
    @api_helper ||= APIMethods::User.new(server('auth'), server('api'))
  end
end
World(APIMethods)

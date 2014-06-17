#from https://gist.github.com/jnicklas/4129937, https://gist.github.com/jnicklas/d8da686061f0a59ffdf7
require 'timeout'
require 'rspec/expectations'

module WaitSteps
  extend RSpec::Matchers::DSL

  matcher :become_true do
    match do |block|
      begin
        Timeout.timeout(Capybara.default_wait_time) do
          sleep(0.1) until value = block.call
          value
        end
      rescue TimeoutError
        false
      end
    end
  end

  def wait_until
    require 'timeout'
    Timeout.timeout(Capybara.default_wait_time) do
      sleep(0.1) until value = yield
      value
    end
  end
end

World(WaitSteps)
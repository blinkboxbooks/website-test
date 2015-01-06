#from https://gist.github.com/jnicklas/4129937, https://gist.github.com/jnicklas/d8da686061f0a59ffdf7
require 'terminator'
require 'rspec/expectations'

module WaitSteps
  extend RSpec::Matchers::DSL

  #stolen from: https://gist.github.com/tgaff/5094609

  # Ex. expect {logged_in_session?}.to become_true, "User is not logged in as expected"
  matcher :become_true do
    supports_block_expectations
    match do |block|
      begin
        Terminator.terminate(Capybara.default_wait_time) do
          sleep(0.1) until block.call
          true
        end
      rescue Terminator::Error
        false
      end
    end
  end

  matcher :become_false do
    supports_block_expectations
    match do |block|
      begin
        Terminator.terminate(Capybara.default_wait_time) do
          sleep(0.1) until !block.call
          true
        end
      rescue Terminator::Error
        false
      end
    end
  end

  # Ex. expect { page.current_url }.to become( '/#/something_or_other' )
  matcher :become do |expected|
    supports_block_expectations
    match do |block|
      begin
        Terminator.terminate(Capybara.default_wait_time) do
          sleep(0.1) until (block.call == expected)
          true
        end
      rescue Terminator::Error
        false
      end
    end
  end

  #made it up myself, blame @aliaksandr
  def wait_until(description = :default, timeout = Capybara.default_wait_time, &block)
    description = block.source_location.flatten if description == :default
    puts "Waiting until #{description}..."
    Terminator.terminate(timeout) do
      sleep(0.1) until yield
      true
    end
  rescue Terminator::Error
    raise Terminator::Error, "Time out after #{timeout}s of waiting until #{description}"
  end

  def try_to_wait(wait_time_seconds = Capybara.default_wait_time)
    start_time = Time.now
    loop do
      return true if yield
      break unless Time.now - start_time <= wait_time_seconds
      sleep(0.05)
    end
  end
end

World(WaitSteps)

require 'cucumber/rake/task'
require 'fileutils'

class Integer
  def ordinal
    cardinal = self.abs
    digit = cardinal % 10
    if (1..3).include?(digit) && !(11..13).include?(cardinal % 100)
      self.to_s << %w{st nd rd}[digit - 1]
    else
      self.to_s << 'th'
    end
  end
end

namespace :ci do
  namespace :cucumber do

    @run_record = 'rerun.txt'
    @run = 0
    @reruns = 3
    @rerunning_features = ''
    @default_cuke_profile = 'ci-smoke-vagrant'

    def next_run
      @rerunning_features = read_results_of_last_run

      @run += 1
      @run_record = run_record_for(@run)
    end

    def last_run_record
      run_record_for(last_run)
    end

    def last_run
      @run - 1
    end

    def run_record_for(run)
      run == 0 ? 'rerun.txt' : "rerun-#{run}.txt"
    end

    def read_results_of_last_run
      IO.read('./' + @run_record)
    end

    def tests_passed_according_to_record?
      @rerunning_features.to_s.strip.empty?
    end

    def runs_remaining?
      @run < @reruns
    end

    desc 'Rerun Cucumber tasks with rerunning on failure.'
    task :all do
      rm_rf @run_record if File.exists?(@run_record)

      begin
        Rake::Task['ci:cucumber:run'].invoke
      rescue SystemExit
        if File.exist?(@run_record)
          puts "*********************************"
          puts "TESTS FAILED."
          puts "Rerunning tests."
          puts "*********************************"

          next_run

          begin
            puts 'Rerun ' + @run.to_s + ' of ' + @reruns.to_s

            if @run > 1
              Rake::Task['ci:cucumber:rerun'].reenable
            end

            if tests_passed_according_to_record?
              puts "Tests passed according to the record in #{run_record}"
            else
              Rake::Task['ci:cucumber:rerun'].invoke(last_run_record, @run_record)
            end
          rescue SystemExit
            puts 'Tests failed again.'

            if runs_remaining?
              puts 'Retrying'
              puts '*************************************'
              next_run
              retry
            else
              puts 'Retried ' + @run.to_s + ' times, now bailing out.'
            end
          else
            puts 'Awesome! - tests passed again on their ' + @run.to_i.ordinal + ' attempt.'
          end
        end
      end
    end

    #TODO: replace cucumber tasks with a regular task definition and setting ENV['CUCUMBER_OPTS'] inside,
    #as otherwise rake loads all code within Cucumber::Rake::Task.new {} block and raises exceptions if some variables are not passed in.
    desc 'Run Cucumber task with rerun logic.'
    Cucumber::Rake::Task.new(:run) do |t, _args|
      ENV['cucumber_profile'] ||= @default_cuke_profile
      puts "Using #{ENV['cucumber_profile']} cucumber profile"
      t.cucumber_opts = ["-p #{ENV['cucumber_profile']} -f rerun --out rerun.txt"]
    end

    desc 'Rerun Cucumber tests'
    task :rerun, [:last, :current] do |_t, _args|
      ENV['cucumber_profile'] ||= @default_cuke_profile
      puts "Using #{ENV['cucumber_profile']} cucumber profile"

      task = "cuke-#{@run}"
      Cucumber::Rake::Task.new(task) do |t|
        t.cucumber_opts = ["-p #{ENV['cucumber_profile']} @#{args[:last]} -f rerun --out #{args[:current]}"]
      end

      Rake::Task[task].reenable
      Rake::Task[task].invoke
    end
  end
end

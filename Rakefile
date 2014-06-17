require 'cucumber/rake/task'
require 'fileutils'

class Integer
  def ordinal
    cardinal = self.abs
    digit = cardinal%10
    if (1..3).include?(digit) and not (11..13).include?(cardinal%100) 
        self.to_s << %w{st nd rd}[digit-1]
    else
        self.to_s << 'th'
    end
  end
end

namespace :teamcity do
  namespace :cucumber do 

    @last_run_record = 'rerun.txt'
    @run = 0
    @reruns = 3
    @rerunning_features = ''

    def next_run
      @rerunning_features = read_results_of_last_run

      @run += 1

      # By default Rake only lets you run a task twice, so we need to reenable it after the second run.
      if @run > 1
          Rake::Task['teamcity:cucumber:rerun'].reenable
      end

      @last_run_record = run_record_for(@run)
    end

    def run_record_for(run)
      if run == 0
        'rerun.txt'
      else
        "rerun-#{@run}.txt"
      end
    end

    def read_results_of_last_run
      IO.read('./' + @last_run_record)
    end

    def tests_passed_according_to_record?
      @rerunning_features.to_s.strip.empty?
    end

    def runs_remaining?
      @run <= @reruns
    end

    desc 'Rerun Cucumber tasks with rerunning on failure.'
    task :all do
        if File.exists?(@last_run_record)
            rm_rf @last_run_record
        end

        begin
          Rake::Task['teamcity:cucumber:run'].invoke
        rescue SystemExit
          if File.exist?(@last_run_record)
            puts "*********************************"
            puts "TESTS FAILED."
            puts "Rerunning tests."
            puts "*********************************"

            next_run

            begin
              puts 'Rerun ' + @run.to_s + ' of ' + @reruns.to_s

              Rake::Task['teamcity:cucumber:rerun'].invoke(@run) unless tests_passed_according_to_record?

            rescue SystemExit
              puts 'Tests failed again, retrying.'

              next_run

              if runs_remaining?
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

    desc 'Run Cucumber task with rerun logic.'
    Cucumber::Rake::Task.new(:run) do | t |
      t.cucumber_opts = ['-p ci-smoke-local --tags @production HEADLESS=true FAIL_FAST=false -f rerun --out rerun.txt']
    end

    # Cucumber just chucks away arguments passed in the standard Rake way so we have to do this.
    desc 'Rerun Cucumber tests'
    task :rerun, [:run_number ]  do | t, args |
      Cucumber::Rake::Task.new(:cuke) do | t |
        t.cucumber_opts = "-p ci-smoke-local @rerun.txt HEADLESS=true FAIL_FAST=false -f rerun --out rerun-#{args[:run_number]}.txt"
      end

      Rake::Task['cuke'].invoke
    end
  end
end
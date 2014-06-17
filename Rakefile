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

    @run_record = 'rerun.txt'
    @run = 0
    @reruns = 3
    @rerunning_features = ''

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
      if run == 0
        'rerun.txt'
      else
        "rerun-#{run}.txt"
      end
    end

    def read_results_of_last_run
      IO.read('./' + @run_record)
    end

    def tests_passed_according_to_record?
      @rerunning_features.to_s.strip.empty?
    end

    def runs_remaining?
      @run <= @reruns
    end

    desc 'Rerun Cucumber tasks with rerunning on failure.'
    task :all do
        if File.exists?(@run_record)
            rm_rf @run_record
        end

        begin
          Rake::Task['teamcity:cucumber:run'].invoke
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
                  Rake::Task['teamcity:cucumber:rerun'].reenable
                end

                unless tests_passed_according_to_record?
                  Rake::Task['teamcity:cucumber:rerun'].invoke(last_run_record, @run_record)                  
                else
                  puts "Tests passed according to the record in #{run_record}"
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

    desc 'Run Cucumber task with rerun logic.'
    Cucumber::Rake::Task.new(:run) do | t |
      t.cucumber_opts = ['-p ci-smoke-local features/manage/manage_your_personal_details.feature:21 --tags @production HEADLESS=true FAIL_FAST=false -f rerun --out rerun.txt']
    end

    desc 'Rerun Cucumber tests'
    task :rerun, [:last, :current]  do | t, args |
      task = "cuke-#{@run}"

      Cucumber::Rake::Task.new(task) do | t |
        t.cucumber_opts = ["-p ci-smoke-local @#{args[:last]} HEADLESS=true FAIL_FAST=false -f rerun --out #{args[:current]}"]
      end

      Rake::Task[task].reenable
      Rake::Task[task].invoke
    end
  end
end
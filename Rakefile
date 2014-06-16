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

    def get_record(run = 0)
      if run == 0
        'rerun.txt'
      else
        "rerun-#{run}.txt"
      end
    end

    def read_rerun(record)
      IO.read('./' + record)
    end

    desc 'Rerun Cucumber tasks with rerunning on failure.'
    task :all do
        first_run_record = get_record

        if File.exists?(first_run_record)
            rm_rf first_run_record
        end

        begin
          Rake::Task['teamcity:cucumber:run'].invoke
        rescue SystemExit
          if File.exist?(first_run_record)
            puts "*********************************"
            puts "TESTS FAILED."
            puts "Rerunning tests."
            puts "*********************************"

            reruns = 1
            run = 1
            rerun_features = read_rerun(first_run_record)

            stats = []

            stats.push(rerun_features)

            begin
              puts 'Rerun ' + run.to_s + ' of ' + reruns.to_s

              # By default Rake only lets you run a task twice, so we need to reenable it after the second run.
              if run > 1
                  Rake::Task['teamcity:cucumber:rerun'].reenable
              end

              Rake::Task['teamcity:cucumber:rerun'].invoke(run) unless rerun_features.to_s.strip.empty?
            rescue SystemExit
              puts 'Tests failed again, retrying.'
              stats.push(read_rerun(get_record(run)))

              run += 1

              if run <= reruns
                  retry
              else
                  puts 'Retried ' + run.to_s + ' times, now bailing out.'
                  puts stats.inspect
              end 
            else
              puts 'Awesome! - tests passed again on their ' + run.to_i.ordinal + ' attempt.'
            end             
          end
      end
    end

    desc 'Run Cucumber task with rerun logic.'
    Cucumber::Rake::Task.new(:run) do | t |
      t.cucumber_opts = ['-p ci-smoke-local --tags @production HEADLESS=true FAIL_FAST=false -f rerun --out rerun.txt']
    end

    desc 'Rerun Cucumber tests'
    task :rerun, [:run_number]  do | t, args |
      Cucumber::Rake::Task.new(:cuke) do | t |
        t.cucumber_opts = "-p ci-smoke-local @rerun.txt HEADLESS=true FAIL_FAST=false -f rerun --out rerun-#{args[:run_number]}.txt"
      end

      Rake::Task['cuke'].invoke
    end
  end
end
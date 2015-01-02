require 'cucumber/blinkbox/formatter/html'

# cucumber/blinkbox/formatter/html extended with support of taking browser screenshots on failures
module Cucumber
  module Blinkbox
    module Formatter
      class Html
        require 'base64'

        def save_screenshot_with_filename_based_on(filename_base)
          #figure out path to the report HtmlFile (@io will contain filepath - see Cucumber::Formatter::Html)
          #we will put "screenshots" folder in the same location.
          screen_dir = File.join(File.dirname(@io.path), 'screenshots')
          Dir.mkdir(screen_dir) unless File.directory?(screen_dir)
          file = File.join(screen_dir, "FAILED_#{filename_base.to_s.gsub(' ', '_').gsub(/[^0-9A-Za-z_]/, '')}.png")
          begin
            driver = Capybara.page.driver
            if driver.respond_to?(:save_screenshot)
              driver.save_screenshot(file)
            elsif driver.respond_to?(:browser) && driver.browser.respond_to?(:save_screenshot)
              driver.browser.save_screenshot(file)
            else
              driver.render(file)
            end
            image = Base64.encode64(open(file).to_a.join)
            embed image, 'image/png', 'CLICK TO VIEW/HIDE SCREENSHOT'
          rescue => e
            puts 'TAKING SCREENSHOT FAILED'
            puts e.message
            puts e.backtrace
          end
        end

        def after_step_result(keyword, step_match, multiline_arg, status, exception, source_indent, background, file_colon_line)
          super(keyword, step_match, multiline_arg, status, exception, source_indent, background, file_colon_line)

          save_screenshot_with_filename_based_on(step_match.step_definition) if status == :failed
        end

        def after_table_row(table_row)
          return if @hide_this_step
          print_table_row_messages
          @builder << '</tr>'
          if table_row.exception
            @builder.tr do
              @builder.td(:colspan => @col_index.to_s, :class => 'failed') do
                @builder.pre do |pre|
                  pre << h(format_exception(table_row.exception))
                end
              end
            end
            if table_row.exception.is_a? ::Cucumber::Pending
              set_scenario_color_pending
            else
              save_screenshot_with_filename_based_on(table_row)
              set_scenario_color_failed
            end
          end
          @outline_row += 1 if @outline_row
          @step_number += 1
          move_progress
        end
      end
    end
  end
end

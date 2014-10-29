`bundle exec cucumber -p release-server-testing SERVER=SERVER_#{ARGV[0]} > output.log`

log = IO.read("output.log")
if log.include?('Failing Scenarios')
    puts "\nTest(s) has been failed."
    exit 1
else
    puts "\nAll passed!"
    exit 0
end

if failures.empty?
    puts "\nAll passed!"
    exit 0
    else

end
if system("bundle exec cucumber -p release-server-testing wait_time=10 SERVER=SERVER_#{ARGV[0]} > output.log")
    puts("All scenarios have passed on this server")
    exit(0)
    else
    puts("Some scenarios have failed on this server")
    exit(1)
end
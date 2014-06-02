#!/bin/bash
set -e
source ~/.bash_profile

# use nginx 'dist' config and restart nginx
vagrant ssh-config | ssh -F /dev/stdin default 'sudo cp /vagrant/vagrant-conf/nginx/ci-conf/nginx.conf /usr/local/nginx/conf;sudo service nginx reload'

# start SWA (but detached so we don't block)
vagrant ssh-config | ssh -F /dev/stdin default 'cd /vagrant/server-web-app/dist;killall node;node app.js' &

# Fetch web test code
rm -rf website-test
git clone git@git.mobcastdev.com:TEST/website-test.git
cd website-test
rvm use 2.0.0
bundle install

# Ignore output - thus making this return true regardless of real error code.
bundle exec cucumber -p ci-smoke-local --tags @production HEADLESS=true FAIL_FAST=false -f rerun --out ./rerun.txt || true

response=1

if [ -e './rerun.txt' ]; then
	echo "Tests failed."
	echo "Rerunning tests."
	for i in {1..3}; do
		echo "Rerun attempt $i"

		# Only rerun the first set of failures.
		bundle exec cucumber @rerun.txt -f rerun --out "./rerun-$i.txt" || true

		# If rerun doesn't exist...
		if [ ! -f './rerun-$i.txt' ]; then
			response=0
			break
		fi
	done
	exit $response
fi
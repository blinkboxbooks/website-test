#!/bin/bash
# Run within TeamCity to bootstrap tests and rerun them.

# Ignore output - thus making this return true regardless of real error code.
bundle exec cucumber -p ci-smoke-local --tags @production HEADLESS=true FAIL_FAST=false -f rerun --out ./rerun.txt || true

if [ -e './rerun.txt' ]; then
	response=1
	echo "*********************************"
	echo "TESTS FAILED."
	echo "Rerunning tests."
	echo "*********************************"
	for i in {1..3}; do
		echo "Rerun attempt $i"

		# Only rerun the first set of failures.
		bundle exec cucumber -p ci-smoke-local @rerun.txt HEADLESS=true FAIL_FAST=false  -f rerun --out "./rerun-$i.txt" || true

		# If rerun doesn't exist...
		if [ ! -f './rerun-$i.txt' ]; then
			response=0
			break
		fi
	done
	exit $response
fi
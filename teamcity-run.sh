#!/bin/bash
# Run tests within TeamCity and rerun on failure.

# Ignore output - thus making this return true regardless of real error code.
bundle exec cucumber -p ci-smoke-local --tags @production HEADLESS=true FAIL_FAST=false -f rerun --out ./rerun.txt || true

if [ -e './rerun.txt' ]; then
	
	echo "*********************************"
	echo "TESTS FAILED."
	echo "Rerunning tests."
	echo "*********************************"

	for i in {1..3}; do
		response=1
		
		echo "Rerun attempt $i/3"

		# Only rerun the first set of failures.
		bundle exec cucumber -p ci-smoke-local @rerun.txt HEADLESS=on FAIL_FAST=false  -f rerun --out "./rerun-$i.txt" || true

		# If rerun doesn't exist...
		if [ ! -f "./rerun-$i.txt" ]; then
			response=0
			break
		fi
	done

	echo $response
	exit $response
fi
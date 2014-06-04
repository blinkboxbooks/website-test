#!/bin/bash
# Run tests within TeamCity and rerun on failure.
function error { 
	echo "$@" >&2; 
}

function run_tests_outputting_to {
	bundle exec cucumber -p ci-smoke-local --tags @production HEADLESS=true FAIL_FAST=false -f rerun --out "$1" || true
}

function rerun_tests_from_file_outputting_to {
	bundle exec cucumber -p ci-smoke-local @rerun.txt HEADLESS=true FAIL_FAST=false -f rerun --out "$1" || true	
}


# Ignore output - thus making this return true regardless of real error code.
run_tests_outputting_to ./rerun.txt

if [ -e './rerun.txt' ]; then
	
	error "*********************************"
	error "TESTS FAILED."
	error "Rerunning tests."
	error "*********************************"

	for i in {1..3}; do
		response=1
		
		error "Rerun attempt $i/3"

		# Only rerun the first set of failures.
		rrerun_tests_from_file_outputting_to "./rerun-$i.txt"

		# If rerun doesn't exist...
		if [ ! -f "./rerun-$i.txt" ]; then
			response=0
			break
		fi
	done

	exit $response
fi
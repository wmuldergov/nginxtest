#!/bin/sh

# Function to run the command
run_periodic_task() {
    run-parts /etc/periodic/15min
}

# Infinite loop to run the command every minute
while true; do
    run_periodic_task
    sleep 60
done

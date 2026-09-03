#!/bin/bash

current_date=$(date)
current_hostname=$(hostname)
current_username=$(whoami)
output_directory="system_info"
process_file="running_processes.txt"

read -p "Enter your name: " name

echo "Name: $name"
echo "Date: $current_date"
echo "Hostname: $current_hostname"
echo "Username: $current_username"

echo "Disk usage:"
df -h

echo "Running processes:"
mkdir -p "$output_directory"
touch "$output_directory/$process_file"
ps > "$output_directory/$process_file"
ps

echo "Process information saved to $output_directory/$process_file"

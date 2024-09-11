#!/bin/bash

# Check if the required environment variables are set
if [ -z "$NUM_REQUESTS" ] || [ -z "$NUM_CONCURRENT" ] || [ -z "$NUM_CURL_REQUESTS" ]; then
  echo "Error: NUM_REQUESTS, NUM_CONCURRENT and NUM_CURL_REQUESTS environment variables must be set."
  echo "Usage: NUM_REQUESTS=<number_of_requests> NUM_CONCURRENT=<number_of_concurrent_requests> NUM_CURL_REQUESTS=<number_of_curl_requests>  ./test.sh"
  exit 1
fi

# Fetch the alb_dns_name from Terraform outputs
ALB_DNS=$(terraform -chdir=tf-code/$ENV output -raw alb_dns_name)

# Check if ALB DNS was retrieved successfully
if [ -z "$ALB_DNS" ]; then
  echo "Failed to retrieve ALB DNS from Terraform outputs"
  exit 1
fi

# Display the ALB DNS being tested
echo "Performing load test on ALB: $ALB_DNS"

# Perform load test using Apache Bench (ab)
# The test runs with the provided number of requests and concurrency
ab -n "$NUM_REQUESTS" -c "$NUM_CONCURRENT" http://$ALB_DNS/

# Output if the test completes
echo "Load test completed on $ALB_DNS"

# Perform the curl requests n times, where n is NUM_CURL_REQUESTS
echo "Performing $NUM_CURL_REQUESTS curl requests to the ALB: $ALB_DNS to check Load Balancing is working correctly"

# Initialize an array to store the hostnames
declare -A hostnames

# Perform curl requests and collect hostnames
for ((i=1; i<=NUM_CURL_REQUESTS; i++)); do
  echo "Curl request #$i to http://$ALB_DNS/"

  # Capture the response and extract the hostname using grep and sed
  response=$(curl -s http://$ALB_DNS/)

  # Extract the hostname (assuming it's in the format: <h1>Welcome to the EC2 instance: ip-xxx-xxx-xxx-xxx</h1>)
  hostname=$(echo "$response" | grep -oP '(?<=EC2 instance: ).*(?=</h1>)')

  # Check if the request was successful and the hostname was extracted
  if [ -n "$hostname" ]; then
    echo "Response hostname: $hostname"

    # Add the hostname to the array (use associative array to avoid duplicates)
    hostnames["$hostname"]=1
  else
    echo "Warning: Failed to extract hostname from response on request #$i"
  fi
done

# Output the unique hostnames
echo "Unique hostnames observed:"
for hostname in "${!hostnames[@]}"; do
  echo "$hostname"
done

# Check if more than one unique hostname was observed
if [ ${#hostnames[@]} -gt 1 ]; then
  echo "Success: Load balancer is distributing traffic between multiple instances."
else
  echo "Warning: Only one unique hostname was observed. Load balancing may not be working as expected."
fi
#!/bin/sh

# Check if the required environment variables are set
if [ -z "$NUM_REQUESTS" ] || [ -z "$NUM_CONCURRENT" ]; then
  echo "Error: NUM_REQUESTS and NUM_CONCURRENT environment variables must be set."
  echo "Usage: NUM_REQUESTS=<number_of_requests> NUM_CONCURRENT=<number_of_concurrent_requests> ./test.sh"
  exit 1
fi

# Fetch the alb_dns_name from Terraform outputs
ALB_DNS=$(terraform output -raw alb_dns_name)

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
echo "Performing $NUM_CURL_REQUESTS curl requests to the ALB: $ALB_DNS to check Load Balacing is working correctly"

for ((i=1; i<=NUM_CURL_REQUESTS; i++)); do
  echo "Curl request #$i to http://$ALB_DNS/"
  curl http://$ALB_DNS/
done

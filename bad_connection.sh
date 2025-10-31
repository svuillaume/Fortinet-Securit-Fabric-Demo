#!/usr/bin/env bash

# File containing the list of IPs
IP_FILE="ip_pool.txt"

# Updated ports to check
PORTS=(80 8080 443 8443 22 2222)

# Check if the IP file exists
if [[ ! -f "$IP_FILE" ]]; then
  echo "Error: $IP_FILE does not exist."
  exit 1
fi

# Read each IP from the file and check connectivity for each port
while IFS= read -r ip; do
  for PORT in "${PORTS[@]}"; do
    if nc -w 3 -z "$ip" "$PORT" >/dev/null 2>&1; then
      echo "$ip:$PORT: OK"
    else
      echo "$ip:$PORT: FAIL"
    fi
  done
done < "$IP_FILE"

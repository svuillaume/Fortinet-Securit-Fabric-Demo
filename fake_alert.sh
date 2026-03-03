```bash
#!/bin/bash

# Check if arguments are provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <source_ip> <destination_ip>"
    echo "Example: $0 172.31.10.50 100.100.100.100"
    exit 1
fi

# Get IPs from command line arguments
SRC_IP="$1"
DST_IP="$2"

# Validate that we have both IPs
if [ -z "$SRC_IP" ] || [ -z "$DST_IP" ]; then
    echo "Error: Both source and destination IPs are required"
    echo "Usage: $0 <source_ip> <destination_ip>"
    exit 1
fi

# Generate unique values for each run
TIMESTAMP=$(date -u +"%d %b %Y %H:%M:%S GMT")
EVENT_ID="TEST-$(date +%s)-$RANDOM"
GUID="FORTINET_$(date +%s)"

# Convert source IP to dashed format for host_ip
HOST_IP_DASHED=$(echo $SRC_IP | tr '.' '-')

echo "Sending test alert..."
echo "  Event ID: $EVENT_ID"
echo "  Timestamp: $TIMESTAMP"
echo "  Source IP: $SRC_IP"
echo "  Destination IP: $DST_IP"
echo ""

curl -X POST "https://cnapp.duckdns.org/fazfec?token="xxxxx" \
  -H "Content-Type: application/json" \
  -d "{
  \"event_title\": \"Malicious IP Connection Attempt\",
  \"event_link\": \"https://login.lacework.net?intgGuid=${GUID}\",
  \"lacework_account\": \"FORTINETCANADADEMO\",
  \"event_source\": \"FortiCNAPP\",
  \"event_description\": \"Critical alert: ${SRC_IP} from host ip-${HOST_IP_DASHED} attempted connection to bad external IP ${DST_IP}\",
  \"event_timestamp\": \"${TIMESTAMP}\",
  \"event_type\": \"ThreatDetection\",
  \"event_id\": \"${EVENT_ID}\",
  \"event_severity\": \"1\"
}"

echo ""
echo "Alert sent successfully!"
```

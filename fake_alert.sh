```bash
====================================
FortiCNAPP FEC Alert Test Generator
====================================

Alert Types:
  1) Bad Login Attempt
  2) Malicious IP Connection

Select alert type [1-2, default: 1]: 1

Enter FEC Token [default: c7ddc09d-5b9b-4a24-bc24-c0f48186da30]: 
Enter Source IP [default: 172.31.10.50]: 
Enter Username [default: admin]: 
Enter Hostname [default: web-server-01]: 

====================================
Generating BAD LOGIN alert with:
  Token: c7ddc09d-5b9b-4a24-bc24-c0f48186da30
  Source IP: 172.31.10.50
  Username: admin
  Hostname: web-server-01
====================================

Sending test alert...
  Event ID: TEST-1772551886-533
  Timestamp: 03 Mar 2026 15:31:26 GMT

OK

====================================
Alert sent successfully!
====================================
svuillaume@Ot-SVuillaume-Mac ~ % ./fake_alert.sh
====================================
FortiCNAPP FEC Alert Test Generator
====================================

Alert Types:
  1) Bad Login Attempt
  2) Malicious IP Connection

Select alert type [1-2, default: 1]: 2

Enter FEC Token [default: c7ddc09d-5b9b-4a24-bc24-c0f48186da30]: 
Enter Source IP [default: 172.31.10.50]: 172.10.10.10
Enter Destination IP [default: 100.100.100.100]: 101.101.101.101

====================================
Generating MALICIOUS CONNECTION alert with:
  Token: c7ddc09d-5b9b-4a24-bc24-c0f48186da30
  Source IP: 172.10.10.10
  Destination IP: 101.101.101.101
====================================

Sending test alert...
  Event ID: TEST-1772552029-4245
  Timestamp: 03 Mar 2026 15:33:49 GMT

OK

====================================
Alert sent successfully!
====================================
svuillaume@Ot-SVuillaume-Mac ~ % cat fake_alert.sh 
#!/bin/bash

# Function to validate IP address
validate_ip() {
    local ip=$1
    local valid_ip_regex="^([0-9]{1,3}\.){3}[0-9]{1,3}$"
    
    if [[ $ip =~ $valid_ip_regex ]]; then
        return 0
    else
        return 1
    fi
}

echo "===================================="
echo "FortiCNAPP FEC Alert Test Generator"
echo "===================================="
echo ""
echo "Alert Types:"
echo "  1) Bad Login Attempt"
echo "  2) Malicious IP Connection"
echo ""
read -p "Select alert type [1-2, default: 1]: " ALERT_TYPE
ALERT_TYPE=${ALERT_TYPE:-1}

echo ""

# Prompt for TOKEN
read -p "Enter FEC Token [default: c7ddc09d-5b9b-4a24-bc24-c0f48186da30]: " TOKEN
TOKEN=${TOKEN:-c7ddc09d-5b9b-4a24-bc24-c0f48186da30}

# Prompt for Source IP with validation
while true; do
    read -p "Enter Source IP [default: 172.31.10.50]: " SRC_IP
    SRC_IP=${SRC_IP:-172.31.10.50}
    if validate_ip "$SRC_IP"; then
        break
    else
        echo "  ERROR: Invalid IP address format. Please try again."
    fi
done

# For bad login, ask for username
if [ "$ALERT_TYPE" == "1" ]; then
    read -p "Enter Username [default: admin]: " USERNAME
    USERNAME=${USERNAME:-admin}
    
    read -p "Enter Hostname [default: web-server-01]: " HOSTNAME
    HOSTNAME=${HOSTNAME:-web-server-01}
else
    # For malicious connection, ask for destination IP
    while true; do
        read -p "Enter Destination IP [default: 100.100.100.100]: " DST_IP
        DST_IP=${DST_IP:-100.100.100.100}
        if validate_ip "$DST_IP"; then
            break
        else
            echo "  ERROR: Invalid IP address format. Please try again."
        fi
    done
fi

echo ""
echo "===================================="

# Generate unique values for each run
TIMESTAMP=$(date -u +"%d %b %Y %H:%M:%S GMT")
EVENT_ID="TEST-$(date +%s)-$RANDOM"
GUID="FORTINET_$(date +%s)"

# Convert source IP to dashed format for host_ip
HOST_IP_DASHED=$(echo $SRC_IP | tr '.' '-')

# Build alert based on type
if [ "$ALERT_TYPE" == "1" ]; then
    EVENT_TITLE="Failed Login Attempt Detected"
    EVENT_DESCRIPTION="Failed login attempt for user ${USERNAME} from ${SRC_IP} from host ${HOSTNAME}"
    EVENT_TYPE="AuthenticationFailure"
    
    echo "Generating BAD LOGIN alert with:"
    echo "  Token: $TOKEN"
    echo "  Source IP: $SRC_IP"
    echo "  Username: $USERNAME"
    echo "  Hostname: $HOSTNAME"
else
    EVENT_TITLE="Malicious IP Connection Attempt"
    EVENT_DESCRIPTION="Critical alert: ${SRC_IP} from host ip-${HOST_IP_DASHED} attempted connection to bad external IP ${DST_IP}"
    EVENT_TYPE="ThreatDetection"
    
    echo "Generating MALICIOUS CONNECTION alert with:"
    echo "  Token: $TOKEN"
    echo "  Source IP: $SRC_IP"
    echo "  Destination IP: $DST_IP"
fi

echo "===================================="
echo ""
echo "Sending test alert..."
echo "  Event ID: $EVENT_ID"
echo "  Timestamp: $TIMESTAMP"
echo ""

curl -X POST "https://cnapp.duckdns.org/fazfec?token=${TOKEN}" \
  -H "Content-Type: application/json" \
  -d "{
  \"event_title\": \"${EVENT_TITLE}\",
  \"event_link\": \"https://login.lacework.net?intgGuid=${GUID}\",
  \"lacework_account\": \"FORTINETCANADADEMO\",
  \"event_source\": \"FortiCNAPP\",
  \"event_description\": \"${EVENT_DESCRIPTION}\",
  \"event_timestamp\": \"${TIMESTAMP}\",
  \"event_type\": \"${EVENT_TYPE}\",
  \"event_id\": \"${EVENT_ID}\",
  \"event_severity\": \"1\"
}"

echo ""
echo "===================================="
echo "Alert sent successfully!"
echo "===================================="
```

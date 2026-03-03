'
curl -X POST "https://cnapp.duckdns.org/fazfec?token=xxxxxxxxxx" \
  -H "Content-Type: application/json" \
  -d '{
  "event_title": "Malicious IP Connection Attempt",
  "event_link": "https://login.lacework.net?intgGuid=FORTINET_TEST003",
  "lacework_account": "FORTINETCANADADEMO",
  "event_source": "FortiCNAPP",
  "event_description": "Critical alert: 172.31.10.50 from host ip-172-31-10-50 attempted connection to bad external IP 192.0.2.100",
  "event_timestamp": "03 Mar 2026 15:10 GMT",
  "event_type": "ThreatDetection",
  "event_id": "TEST-SRC-DST-003",
  "event_severity": "1"
}'


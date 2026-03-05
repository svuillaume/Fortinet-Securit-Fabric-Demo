Perfect! Here’s a single Markdown file combining Docker build/push steps and the Kubernetes manifest for your outbound beacon container. This is a full reference for your lab or CNAPP demo.

# Outbound Beacon Lab - Docker & Kubernetes

This document summarizes all steps to build, push, and deploy the `outbound-beacon` container for Kubernetes. It is suitable for CNAPP/Lacework runtime testing.

---

## 1. Create the Beacon Script

Save as `beacon.sh`:

```bash
#!/bin/bash

IPS=(
"208.94.116.246 443"
"92.118.39.212 3389"
"111.26.95.254 22"
)

while true
do
    for target in "${IPS[@]}"
    do
        ip=$(echo $target | awk '{print $1}')
        port=$(echo $target | awk '{print $2}')

        (
            echo "$(date) Connecting to $ip:$port"
            nc -v $ip $port &
            pid=$!
            sleep 30
            kill $pid 2>/dev/null
            echo "$(date) Connection closed for $ip:$port"
        ) &
    done

    sleep $((RANDOM % 20 + 10))
done

Make it executable:

chmod +x beacon.sh


⸻

2. Create the Dockerfile

FROM alpine:3.20

RUN apk add --no-cache bash netcat-openbsd

WORKDIR /app

COPY beacon.sh .

RUN chmod +x beacon.sh

CMD ["bash", "/app/beacon.sh"]


⸻

3. Build the Docker Image

docker build -t outbound-beacon:1.0 .

Verify:

docker images


⸻

4. Tag the Image for Docker Hub

docker tag outbound-beacon:1.0 sam052007/outbound-beacon:1.0

Verify:

docker images

You should see:

sam052007/outbound-beacon   1.0


⸻

5. Login to Docker Hub

docker login

Enter your username (sam052007) and password or access token.
Expected:

Login Succeeded


⸻

6. Push Image to Docker Hub

docker push sam052007/outbound-beacon:1.0

Expected output:

The push refers to repository [docker.io/sam052007/outbound-beacon]
layer1: Pushed
layer2: Pushed
1.0: digest: sha256:xxxx

⚠️ If the repository is private, Kubernetes nodes need a secret to pull it.

⸻

7. Verify Image Pull

docker pull sam052007/outbound-beacon:1.0


⸻

8. Kubernetes Deployment Manifest

Save as outbound-beacon-deployment.yaml:

apiVersion: apps/v1
kind: Deployment
metadata:
  name: outbound-beacon
  labels:
    app: outbound-beacon
spec:
  replicas: 1   # Increase to simulate more parallel outbound connections
  selector:
    matchLabels:
      app: outbound-beacon
  template:
    metadata:
      labels:
        app: outbound-beacon
    spec:
      containers:
        - name: beacon
          image: sam052007/outbound-beacon:1.0
          imagePullPolicy: Always
          resources:
            limits:
              memory: "200Mi"
              cpu: "500m"
            requests:
              memory: "100Mi"
              cpu: "200m"
          tty: true
          stdin: true
      restartPolicy: Always


⸻

9. Deploy to Kubernetes

kubectl apply -f outbound-beacon-deployment.yaml

Check status:

kubectl get pods -l app=outbound-beacon

View logs:

kubectl logs -f <pod-name>


⸻

10. Optional: Scale Deployment

Simulate multiple beacon pods:

kubectl scale deployment outbound-beacon --replicas=3


⸻

11. Optional: Use Private Image with Secret
	1.	Create Docker Hub secret:

kubectl create secret docker-registry dockerhub-secret \
  --docker-username=sam052007 \
  --docker-password=<token_or_password> \
  --docker-email=<email>

	2.	Add to deployment:

spec:
  imagePullSecrets:
    - name: dockerhub-secret


⸻

✅ Notes
	•	This container generates repeated outbound connections, useful for runtime security testing.
	•	Works well with CNAPP tools like Lacework or FortiCNAPP to simulate anomalous outbound traffic.
	•	Use resource limits to prevent the container from consuming excessive CPU/memory.
	•	Increasing replicas gives a better simulation of a distributed beaconing scenario.

---

## microk8s kubectl exec outbound-beacon-79c4d9fc48-jfmsl -- netstat -tn | grep ESTABLISHED

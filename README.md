# Fortinet Security Fabric Demo

## 🎯 Goal
Demonstrate **Fortinet Security Fabric automation** across **hybrid and public cloud environments**.

---

## 🧩 Context

This demonstration is designed purely for **educational and proof-of-concept** purposes.

Under normal conditions, a **FortiGate IPS profile** would typically detect and block traffic to known malicious IP addresses.  
However, in today’s threat landscape — especially with **zero-day attacks** and **rapidly evolving attacker infrastructure** — not every suspicious IP is immediately classified as “bad.”

This is where **FortiCNAPP** significantly enhances the Fortinet Security Fabric.  
By combining **composite indicators** with **advanced anomaly detection**, it can identify unusual callback activity even when the IP has not yet been flagged as malicious.

This capability is particularly powerful in detecting early signs of:
- **Data exfiltration**
- **Ransomware callbacks**
- **Compromised hosts** communicating with external command-and-control servers

Together, FortiGate, FortiAnalyzer, and FortiCNAPP provide **visibility and protection** well beyond traditional, signature-based defenses.

---

## ☁️ Overview

This demo showcases a **multi-cloud deployment** spanning **Microsoft Azure** and **Amazon Web Services (AWS)**, integrated with an **on-premises Fortinet Security Fabric**.

### Components

- **FG (FortiGate)** — Next-Generation Firewall (NGFW) providing advanced network protection  
  🔗 [FortiGate Product Page](https://www.fortinet.com/products/next-generation-firewall)

- **FAZ (FortiAnalyzer)** — Centralized analytics and automation platform for log and telemetry analysis  
  🔗 [FortiAnalyzer Product Page](https://www.fortinet.com/products/management/fortianalyzer)

- **FortiCNAPP** — Unified Cloud-Native Application Protection Platform (CNAPP) providing visibility and security across multi-cloud environments  
  🔗 [FortiCNAPP Product Page](https://www.fortinet.com/products/forticnapp)

---

## 🧠 Multi-Cloud Fortinet Security Fabric

![Fortinet Security Fabric Diagram](https://github.com/user-attachments/assets/0c6cc7e8-ba09-42fc-8bed-159b568724af)

---

## 🧱 Demo Environment

![Demo Environment](https://github.com/user-attachments/assets/4cb3a3f5-2535-410b-9a1a-2ce04be29599)

---

## 🧭 Demo Steps

### 1. FortiAnalyzer
- Ensure FortiAnalyzer has a **TLS CA-signed certificate** (e.g., via **Let’s Encrypt**).
- Add **FortiGate (FG)** as a managed device in **FortiAnalyzer (FAZ)**.
- Connect **FG** to **FAZ Fabric**.

---

### 2. On FortiGate

![FortiGate Fabric Connection](https://github.com/user-attachments/assets/2ecbf134-b5f1-4fe3-8939-6ed3ed395500)
![FortiGate Config](https://github.com/user-attachments/assets/55198d1c-0192-47d4-9e55-52d656a42d04)

> ⚠️ **Important:** Verify that the **FortiAnalyzer certificate** is properly validated.

#### Enable Log Forwarding to FAZ

![Log Forwarding](https://github.com/user-attachments/assets/4dc934da-da6c-4f34-a440-ce83cd6b0eb8)

#### Create the Automation Stitch / Playbook

![Automation Playbook](https://github.com/user-attachments/assets/5b094a87-c388-4166-8911-3129aa64142c)

#### Create a New Playbook

![New Playbook](https://github.com/user-attachments/assets/f4c1324c-fa9f-4360-b11d-2021eaf54aa9)

---

### 3. On FortiAnalyzer

#### Add a New Device (FortiGate)

![Add Device](https://github.com/user-attachments/assets/9067cf3a-aabc-4662-b891-02e818357dc3)

#### Create a New Event Collector and Generate a Token
> This token is required for the **FortiCNAPP–FAZ webhook integration**.

#### Create a New Automation Playbook

![New Automation Playbook](https://github.com/user-attachments/assets/0bdd3bc4-1b05-4096-91fb-8fdba9e6fc28)

#### Configure the Event Trigger

![Event Trigger](https://github.com/user-attachments/assets/76d958b7-3821-49a7-b262-1d7fefd6bee4)

#### Configure the FortiOS Connector

![FortiOS Connector](https://github.com/user-attachments/assets/5e2111f1-b359-4efd-8579-18b8ca5fd2bd)

---

### 4. On FortiCNAPP

#### Create a New Destination Channel Webhook

![FortiCNAPP Webhook](https://github.com/user-attachments/assets/5f370a6b-5799-405d-8a00-4d289c555bc0)

> ⚠️ **Important:** Update the HTTP query with the **FortiAnalyzer token** generated earlier.

---

## ✅ Summary

This demo illustrates how **Fortinet’s Security Fabric** delivers **end-to-end visibility, automation, and coordinated response** across hybrid and multi-cloud environments.  
By integrating **FortiGate**, **FortiAnalyzer**, and **FortiCNAPP**, organizations can detect, correlate, and respond to advanced threats — even when indicators are not yet classified as malicious.

---

*Author: Fortinet Multi-Cloud Demo Project*  
*Version: 1.0*  
*Last Updated: October 2025*












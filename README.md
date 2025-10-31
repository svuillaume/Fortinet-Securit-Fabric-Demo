# Fortinet-Securit-Fabric-Demo

Goal:
Demonstrate Fortinet Security Fabric automation across hybrid and Public Cloud environments.

Overview:
This demo showcases a multi-cloud deployment spanning Microsoft Azure and Amazon Web Services (AWS), on Premises integrating:

FG: FortiGate is a next-generation firewall (NGFW) product line from Fortinet that protects networks from cyber threats: https://www.fortinet.com/products/next-generation-firewall
FAZ: FortiAnalyzer is a security analytics and automation tool from Fortinet that centralizes and analyzes logs and telemetry from FortiGate firewalls and other Fortinet devices: https://www.fortinet.com/products/management/fortianalyzer
FortiCNAPP: FortiCNAPP is a unified Cloud-Native Application Protection Platform (CNAPP) from Fortinet that consolidates various security tools into a single platform to protect cloud and hybrid environments: https://www.fortinet.com/products/forticnapp

Multi-Cloud Fortinet Security Fabric 

<img width="531" height="460" alt="image" src="https://github.com/user-attachments/assets/0c6cc7e8-ba09-42fc-8bed-159b568724af" />

Demo Environment 

<img width="1592" height="1099" alt="image" src="https://github.com/user-attachments/assets/4cb3a3f5-2535-410b-9a1a-2ce04be29599" />

Demo steps:

FortiAnalyser must have a TLS CA signed Certification (use Lets encrypt)

Add FG to FAZ and Connect FG to FAZ fabric

On FG

<img width="1508" height="645" alt="image" src="https://github.com/user-attachments/assets/2ecbf134-b5f1-4fe3-8939-6ed3ed395500" />

<img width="1061" height="387" alt="image" src="https://github.com/user-attachments/assets/55198d1c-0192-47d4-9e55-52d656a42d04" />

IMPORTANT: Verify FortiAnalyzer certificate must be checked 

Enabled Log Forwardin to FAZ

<img width="1047" height="708" alt="image" src="https://github.com/user-attachments/assets/4dc934da-da6c-4f34-a440-ce83cd6b0eb8" />

Create the Automation stick playbook

<img width="1512" height="474" alt="image" src="https://github.com/user-attachments/assets/5b094a87-c388-4166-8911-3129aa64142c" />

Create New

<img width="995" height="824" alt="image" src="https://github.com/user-attachments/assets/f4c1324c-fa9f-4360-b11d-2021eaf54aa9" />

On FAZ

Add new Device - FG

<img width="1200" height="373" alt="image" src="https://github.com/user-attachments/assets/9067cf3a-aabc-4662-b891-02e818357dc3" />

Create new Event Collector and Generate a new Token (this is required for FortiCNAPP FAZ webhook)

Create new Automation plabook

<img width="1510" height="820" alt="image" src="https://github.com/user-attachments/assets/0bdd3bc4-1b05-4096-91fb-8fdba9e6fc28" />

Set uo the Event trigger as follow

<img width="927" height="233" alt="image" src="https://github.com/user-attachments/assets/76d958b7-3821-49a7-b262-1d7fefd6bee4" />

and FortiOS connector

<img width="936" height="430" alt="image" src="https://github.com/user-attachments/assets/5e2111f1-b359-4efd-8579-18b8ca5fd2bd" />

On FortiCNAPP

Create a new Destniation Channel Webhook

<img width="1203" height="490" alt="image" src="https://github.com/user-attachments/assets/5f370a6b-5799-405d-8a00-4d289c555bc0" />

IMPORTANT: update in the http quer the FAZ token previousl generated
















# Microsoft Entra ID Identity Lifecycle Automation

Enterprise identity lifecycle automation using **PowerShell 7** and the **Microsoft Graph PowerShell SDK**.

![PowerShell](https://img.shields.io/badge/PowerShell-7-blue)
![Microsoft Graph](https://img.shields.io/badge/Microsoft-Graph-green)
![Version](https://img.shields.io/badge/version-v1.3.0-success)
![Platform](https://img.shields.io/badge/Platform-Microsoft%20Entra%20ID-0078D4)

---

# Overview

This repository demonstrates a modular Microsoft Entra ID identity lifecycle automation framework built with PowerShell 7 and the Microsoft Graph PowerShell SDK.

The solution automates enterprise onboarding by validating CSV data, provisioning users, creating department security groups, assigning Microsoft 365 licenses, generating provisioning reports, and logging every operation.

The project follows enterprise automation best practices including reusable functions, structured logging, robust error handling, configuration-driven design, and Git-based versioning..

The solution was built following enterprise automation principles:

- Modular reusable functions
- Structured logging
- Error handling
- Git versioning
- Microsoft Graph authentication
- CSV reporting

---

# Features


- Microsoft Graph authentication
- CSV validation
- Bulk user onboarding
- Duplicate user detection
- Automatic password generation
- Department security group automation
- Automatic group membership assignment
- Microsoft 365 license mapping
- License availability validation
- Automatic Microsoft 365 license assignment
- Structured logging
- Provisioning report export
- Modular PowerShell toolkit

---

# Project Architecture

CSV Joiners
      │
      ▼
Validate CSV
      │
      ▼
Connect Microsoft Graph
      │
      ▼
Check Existing User
      │
      ├───────────────┐
      │               │
      ▼               ▼
Already Exists     Create User
      │               │
      └──────┬────────┘
             │
             ▼
Department Group Automation
             │
             ▼
Microsoft 365 License Assignment
             │
             ▼
Generate Provisioning Report
             │
             ▼
Execution Summary
```

---

# Folder Structure

```text
EntraID-Automation-Lab

Config/
Data/
Docs/
Functions/
Logs/
Reports/
Scripts/

README.md
```

---

# Demonstration

## Microsoft Graph Connection

![Microsoft Graph Connection](Docs/Images/GraphConnection.png)

Successfully establishes a delegated Microsoft Graph session before automation begins.

---

## Bulk User Onboarding

![Bulk Onboarding](Docs/Images/BulkOnboarding.png)

Processes the onboarding CSV, validates input, checks existing accounts, creates users, logs execution, and produces a provisioning report.

---

## Users Created in Microsoft Entra ID

![Entra Users](Docs/Images/EntraUsers.png)

Users successfully provisioned into Microsoft Entra ID using Microsoft Graph.

---

## Provisioning Report

![Provisioning Report](Docs/Images/ProvisioningReport.png)

CSV report generated after execution summarizing provisioning results.

---

# Technologies

- PowerShell 7
- Microsoft Graph PowerShell SDK
- Microsoft Entra ID
- Git
- GitHub

---
## Department Group Automation

![Department Groups](Docs/Images/DepartmentGroups.png)

Automatically creates department security groups and assigns users to the appropriate group.

---

## Microsoft 365 License Automation

![License Assignment](Docs/Images/LicenseAutomation.png)

Automatically maps departments to Microsoft 365 licenses, validates license availability, and assigns licenses using Microsoft Graph.
---
# Current Portfolio

| Project | Status | Version |
|---------|:------:|:------:|
| Project 1 – Identity Provisioning | ✅ | v1.0.0 |
| Project 2 – Bulk User Onboarding | ✅ | v1.1.0 |
| Project 3 – Department & Security Group Automation | ✅ | v1.2.0 |
| Project 4 – Microsoft 365 License Automation | ✅ | v1.3.0 |

---

# Upcoming Work

- User Offboarding Automation
- Session Revocation
- License Removal
- Group Cleanup
- Azure Automation Runbooks
- Access Review Reporting
- Azure Key Vault Integration

---
# Skills Demonstrated

- Microsoft Entra ID
- Microsoft Graph PowerShell SDK
- Identity Lifecycle Management
- Microsoft 365 License Management
- RBAC & Security Groups
- PowerShell 7 Automation
- JSON Configuration
- CSV Data Processing
- Git & GitHub
- Modular PowerShell Design
  
---
# Releases

- v1.0.0 – Identity Provisioning
- v1.1.0 – Bulk User Onboarding
- v1.2.0 – Department & Security Group Automation
- v1.3.0 – Microsoft 365 License Automation
  
---

# Roadmap

See the project roadmap for upcoming releases and planned enhancements.

📄 [ROADMAP.md](ROADMAP.md)


### Features

- Automatic department security group creation
- Automatic group discovery
- Automatic group membership assignment
- Membership validation
- Enhanced provisioning reports
- Idempotent access provisioning

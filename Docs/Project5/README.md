# 🚀 Project 5 – Microsoft Entra ID User Offboarding Automation

![PowerShell](https://img.shields.io/badge/PowerShell-7+-5391FE?logo=powershell&logoColor=white)
![Microsoft Graph](https://img.shields.io/badge/Microsoft%20Graph-SDK-0078D4?logo=microsoft&logoColor=white)
![Microsoft Entra ID](https://img.shields.io/badge/Microsoft-Entra%20ID-0078D4)
![Version](https://img.shields.io/badge/Version-v1.4.0-success)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen)

---

## 📖 Overview

Project 5 automates the Microsoft Entra ID user offboarding process using the Microsoft Graph PowerShell SDK.

The solution follows a modular architecture where each administrative task is implemented as an independent PowerShell function. Individual functions can be executed separately or orchestrated through a complete offboarding workflow for both single-user and bulk user scenarios.

This project demonstrates enterprise-style identity lifecycle management by automating common administrative tasks while producing audit-friendly reporting.

---

## 🎯 Objectives

- Automate user offboarding
- Disable Microsoft Entra ID user accounts
- Remove Microsoft 365 licenses
- Remove security group memberships
- Revoke active sign-in sessions
- Generate audit reports
- Support bulk offboarding from CSV
- Demonstrate modular PowerShell development

---

# ✨ Features

✔ Disable user accounts

✔ Remove Microsoft 365 licenses

✔ Remove Microsoft Entra security groups

✔ Revoke active user sessions

✔ Bulk offboarding from CSV

✔ Single-user offboarding

✔ CSV reporting

✔ Error handling

✔ Input validation

✔ Modular PowerShell functions

✔ Enterprise-ready script organization

---

# 🏗 Solution Architecture

```text
                   OffboardingUsers.csv
                            │
                            ▼
              Start-BulkOffboarding.ps1
                            │
                            ▼
                Start-Offboarding.ps1
                            │
     ┌─────────────┬──────────────┬──────────────┬──────────────┐
     ▼             ▼              ▼              ▼
Disable User  Remove Licenses  Remove Groups  Revoke Sessions
     │             │              │              │
     └─────────────┴──────────────┴──────────────┘
                            │
                            ▼
             Export-OffboardingReport.ps1
                            │
                            ▼
                OffboardingReport.csv
```

---

# 📁 Project Structure

```text
Project5-Offboarding
│
├── Config
│
├── Data
│   └── OffboardingUsers.csv
│
├── Functions
│   ├── Disable-EntraUser.ps1
│   ├── Export-OffboardingReport.ps1
│   ├── Import-EntraLab.ps1
│   ├── Remove-UserGroups.ps1
│   ├── Remove-UserLicenses.ps1
│   └── Revoke-UserSessions.ps1
│
├── Reports
│   └── OffboardingReport.csv
│
├── Scripts
│   ├── Start-Offboarding.ps1
│   ├── Start-BulkOffboarding.ps1
│   ├── Test-DisableEntraUser.ps1
│   ├── Test-LicenseRemoval.ps1
│   ├── Test-GroupRemoval.ps1
│   ├── Test-RevokeSessions.ps1
│   └── Test-OffboardingReport.ps1
│
└── README.md
```

---

# ⚙ Prerequisites

- PowerShell 7 or later
- Microsoft Graph PowerShell SDK
- Microsoft Entra ID tenant
- Microsoft 365 test environment
- Appropriate Microsoft Graph permissions

---

# 🔐 Required Microsoft Graph Permissions

| Permission | Purpose |
|------------|---------|
| User.ReadWrite.All | Disable user accounts |
| Group.ReadWrite.All | Remove security group memberships |
| Directory.Read.All | Read directory objects |

---

# 🚀 Getting Started

## Clone the Repository

```powershell
git clone https://github.com/Thierno16/EntraID-Automation-Lab.git

cd EntraID-Automation-Lab
```

---

## Connect to Microsoft Graph

```powershell
Connect-MgGraph -Scopes `
User.ReadWrite.All,
Group.ReadWrite.All,
Directory.Read.All
```

---

# 👤 Single User Offboarding

```powershell
.\Scripts\Start-Offboarding.ps1 `
-UserPrincipalName "john.smith@contoso.com"
```

---

# 👥 Bulk User Offboarding

Prepare a CSV file:

```csv
UserPrincipalName
john.smith@contoso.com
mary.jones@contoso.com
alex.wilson@contoso.com
```

Run:

```powershell
.\Scripts\Start-BulkOffboarding.ps1
```

---

# 📊 Sample Report

| Display Name | Action | Status |
|--------------|--------|--------|
| John Smith | Disable Account | Success |
| John Smith | Remove Licenses | Success |
| John Smith | Remove Groups | Success |
| John Smith | Revoke Sessions | Success |

---

# 🛠 Technologies Used

- PowerShell 7
- Microsoft Graph PowerShell SDK
- Microsoft Entra ID
- Microsoft 365
- CSV Processing
- Git
- GitHub

---

# 🎓 Skills Demonstrated

## Identity Administration

- Microsoft Entra ID
- Identity Lifecycle Management
- User Offboarding
- Microsoft 365 Administration

## PowerShell

- Modular scripting
- Functions
- Error handling
- Validation
- CSV processing
- Reporting

## Automation

- Microsoft Graph SDK
- Enterprise automation
- Bulk operations
- Identity management

## DevOps

- Git
- GitHub
- Version control
- Documentation

---

# 📸 Screenshots

## Single User Offboarding

> *(Add screenshot here)*

---

## Bulk Offboarding

> *(Add screenshot here)*

---

## CSV Report

> *(Add screenshot here)*

---

## Project Structure

> *(Add screenshot here)*

---

# 📈 Project Highlights

- Enterprise-style modular architecture
- Reusable PowerShell functions
- Bulk and single-user workflows
- Audit-friendly CSV reporting
- Consistent error handling
- Production-inspired project structure

---

# 🔖 Release Information

| Version | Status |
|---------|--------|
| v1.4.0 | Released |

---

# 👤 Author

**Thierno Bah**

IT Engineer | Microsoft Entra ID | PowerShell Automation | Cybersecurity

GitHub: https://github.com/Thierno16

---

## ⭐ Repository Roadmap

| Version | Project | Status |
|---------|---------|--------|
| ✅ v1.0.0 | Identity Provisioning | Complete |
| ✅ v1.1.0 | Bulk User Onboarding | Complete |
| ✅ v1.2.0 | Department & Security Group Automation | Complete |
| ✅ v1.3.0 | Microsoft 365 License Automation | Complete |
| ✅ v1.4.0 | User Offboarding Automation | Complete |
| 🔄 v1.5.0 | Azure Automation Runbooks | Planned |
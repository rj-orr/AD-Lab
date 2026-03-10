# Active Directory Identity Management Lab

This repository contains PowerShell scripts I developed to practice automating the user lifecycle (Joiner-Leaver) in a lab environment.

### Scripts:
* **Onboarding**: Automates account creation from a CSV file. It includes logic to generate sAMAccountNames and sets temporary passwords that must be changed at first logon.
* **Offboarding**: Securely disables accounts, clears group memberships, and moves objects to a dedicated 'Disabled' OU.

### Goal:
To transition manual Active Directory tasks into repeatable scripts that ensure security and data consistency.

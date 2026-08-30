# Active Directory Lab Automation

A collection of automation scripts and utilities for an Active Directory lab.

## The Problem

Doing onboarding and offboarding manually through Active Directory gets tedious and can lead to mistakes.

## The Solution

PowerShell scripts that automate user provisioning and offboarding using CSV files.

## Scripts Included

* **`Onboarding.ps1`**: Pulls data from `new_hires.csv` and generates new user accounts, giving them a temporary password and placing them in the corporate OU.
* **`Offboard-User.ps1`**: Takes a username and then disables the account, removing all of its non-default group memberships and moving it to the disabled OU.

## Usage

1. Place the scripts and your CSV files into your lab directory.
2. Run them from an elevated PowerShell prompt.

---
title: "Add scheduled maintenance"
description: "Use Statusimo to create maintenance events that appear on the generated status page."
layout: docs
---

This pattern is useful when operations teams want upcoming work visible before the window starts.

It comes from the source example at `Examples/Add-Maintenance1.ps1`.

## When to use this pattern

- You need to announce planned maintenance.
- The status page is generated from local event files.
- You want maintenance records to be scriptable.

## Example

```powershell
Import-Module .\Statusimo.psd1 -Force

New-StatusimoMaintenance -Title 'Hyper-V scheduled maintenance' `
    -DateStart (Get-Date).AddDays(5) `
    -DateEnd (Get-Date).AddDays(6).AddHours(2) `
    -Service 'Hyper-V' `
    -Overview 'Updating core infrastructure for Hyper-V.' `
    -FolderPath "$PSScriptRoot\Maintenance"
```

## What this demonstrates

- creating a planned event
- using dates and services in the event record
- feeding the status page generator

## Source

- [Add-Maintenance1.ps1](https://github.com/EvotecIT/Statusimo/blob/master/Examples/Add-Maintenance1.ps1)


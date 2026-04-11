---
title: "Generate a static status page"
description: "Use Statusimo to generate a static HTML status page from local event folders."
layout: docs
---

This pattern is useful when a simple static file can serve the status page without a hosted service.

It comes from the source example at `Examples/Generate-Status.ps1`.

## When to use this pattern

- You want a static status page artifact.
- Incidents and maintenance windows are stored as files.
- You want the output to be deployable anywhere static HTML can live.

## Example

```powershell
Import-Module .\Statusimo.psd1 -Force

New-StatusimoPage -FilePath "$PSScriptRoot\StatusPage.html" `
    -IncidentsPath "$PSScriptRoot\Incidents" `
    -MaintenancePath "$PSScriptRoot\Maintenance"
```

## What this demonstrates

- generating a status page file
- separating incident and maintenance sources
- keeping the publishing step static

## Source

- [Generate-Status.ps1](https://github.com/EvotecIT/Statusimo/blob/master/Examples/Generate-Status.ps1)


param(
    [string]$BaseHref = "/"
)

& "$PSScriptRoot\build_web.ps1" -BaseHref $BaseHref
if ($LASTEXITCODE -ne 0) { exit 1 }

Write-Host "Deploying to Firebase Hosting..." -ForegroundColor Cyan
firebase deploy --only hosting

# ====================================================
# NCAS Grant Management System
# Tools Folder Generator
# Version 1.0
# ====================================================

Write-Host ""
Write-Host "Creating Enterprise Tools Structure..." -ForegroundColor Cyan

$folders = @(
    "tools\scripts",
    "tools\templates",
    "tools\logs",
    "tools\backup",
    "tools\release",
    "tools\deployment"
)

foreach ($folder in $folders) {
    New-Item -ItemType Directory -Force -Path $folder | Out-Null
}

$files = @(

    # Scripts
    "tools\scripts\create-module.ps1",
    "tools\scripts\create-migration.ps1",
    "tools\scripts\create-document.ps1",
    "tools\scripts\create-adr.ps1",
    "tools\scripts\backup-database.ps1",
    "tools\scripts\restore-database.ps1",
    "tools\scripts\create-release.ps1",
    "tools\scripts\deploy.ps1",

    # Templates
    "tools\templates\ADR.md",
    "tools\templates\Module.md",
    "tools\templates\Migration.sql",
    "tools\templates\README.md",
    "tools\templates\DataDictionary.xlsx",

    # Documentation
    "tools\README.md",

    # Git Keep Files
    "tools\logs\.gitkeep",
    "tools\backup\.gitkeep",
    "tools\release\.gitkeep",
    "tools\deployment\.gitkeep"
)

foreach ($file in $files) {
    if (!(Test-Path $file)) {
        New-Item -ItemType File -Path $file | Out-Null
    }
}

Write-Host ""
Write-Host "Enterprise Tools Structure Created Successfully." -ForegroundColor Green
Write-Host ""
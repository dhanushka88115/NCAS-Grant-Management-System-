# ============================================
# NCAS Grant Management System
# Enterprise Project Bootstrap Script
# Version : 1.0.0
# ============================================

Write-Host ""
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host " NCAS Grant Management System"
Write-Host " Project Structure Generator"
Write-Host "=========================================" -ForegroundColor Cyan
Write-Host ""

$folders = @(
    "app",
    "app\Controllers",
    "app\Models",
    "app\Views",
    "app\Core",
    "app\Helpers",
    "app\Middleware",
    "app\Services",
    "app\Repositories",
    "app\Libraries",
    "app\Requests",
    "app\Responses",
    "app\Validators",
    "app\Policies",
    "app\Traits",
    "app\Exceptions",
    "app\Console",

    "config",

    "database",
    "database\migrations",
    "database\seeds",
    "database\views",
    "database\procedures",
    "database\functions",
    "database\triggers",

    "docs",
    "docs\01_Project_Charter",
    "docs\02_SRS",
    "docs\03_Software_Design",
    "docs\04_ER_Diagrams",
    "docs\05_Data_Dictionary",
    "docs\06_Database_Design",
    "docs\07_API",
    "docs\08_Testing",
    "docs\09_Deployment",

    "public",
    "resources",
    "storage",
    "tests",

    ".github",
    ".github\workflows"
)

foreach ($folder in $folders) {
    New-Item -ItemType Directory -Force -Path $folder | Out-Null
}

$files = @(
    "README.md",
    "LICENSE",
    ".gitignore",

    "database\README.md",

    "docs\CHANGELOG.md",

    "config\.gitkeep",
    "storage\.gitkeep",
    "resources\.gitkeep",
    "tests\.gitkeep",

    ".github\workflows\.gitkeep"
)

foreach ($file in $files) {
    if (!(Test-Path $file)) {
        New-Item -ItemType File -Path $file | Out-Null
    }
}

Write-Host ""
Write-Host "Project structure created successfully." -ForegroundColor Green
Write-Host ""
Write-Host "NCAS Enterprise Project is ready." -ForegroundColor Yellow
Write-Host ""
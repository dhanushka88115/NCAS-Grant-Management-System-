# ==========================================================
# NCAS Grant Management System
# Database Documentation Generator
# Version : 1.0.0
# ==========================================================

Write-Host ""
Write-Host "==============================================" -ForegroundColor Cyan
Write-Host " NCAS Database Documentation Generator"
Write-Host "==============================================" -ForegroundColor Cyan
Write-Host ""

#----------------------------------------------------------
# Ensure Documentation Folder Exists
#----------------------------------------------------------

$docFolder = "database\documentation"

New-Item -ItemType Directory -Force -Path $docFolder | Out-Null

#----------------------------------------------------------
# Documentation Files
#----------------------------------------------------------

$documents = @(

"Database_Standards.md",
"Create_Database.md",
"Master_Tables.md",
"User_Management.md",
"Constraints_Indexes.md",
"Triggers.md",
"Views.md",
"Seed_Data.md",
"System_Settings.md"

)

foreach ($doc in $documents)
{
    $path = Join-Path $docFolder $doc

    if (!(Test-Path $path))
    {
        New-Item -ItemType File -Path $path | Out-Null
        Write-Host "Created $doc"
    }
    else
    {
        Write-Host "$doc already exists." -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "==============================================" -ForegroundColor Green
Write-Host " Database Documentation Ready."
Write-Host "=============================================="
Write-Host ""
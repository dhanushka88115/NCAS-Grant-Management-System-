# ==========================================================
# NCAS Grant Management System
# Database Structure Generator
# Version : 1.0.0
# ==========================================================

Write-Host ""
Write-Host "==============================================" -ForegroundColor Cyan
Write-Host " NCAS Database Structure Generator"
Write-Host "==============================================" -ForegroundColor Cyan
Write-Host ""

#----------------------------------------------------------
# Create Directories
#----------------------------------------------------------

$folders = @(

"database\migrations",
"database\seeds",
"database\views",
"database\procedures",
"database\functions",
"database\triggers",
"database\documentation",
"database\diagrams",
"database\backups"

)

foreach ($folder in $folders)
{
    New-Item -ItemType Directory -Force -Path $folder | Out-Null
}

#----------------------------------------------------------
# Create Migration Files
#----------------------------------------------------------

$migrations = @(

"000_database_standards.sql",
"001_create_database.sql",
"002_master_tables.sql",
"003_user_management.sql",
"004_constraints_indexes.sql",
"005_triggers.sql",
"006_views.sql",
"007_seed_data.sql",
"008_system_settings.sql"

)

foreach ($file in $migrations)
{
    $path = "database\migrations\$file"

    if(!(Test-Path $path))
    {
        New-Item -ItemType File -Path $path | Out-Null
    }
}

#----------------------------------------------------------
# Documentation Files
#----------------------------------------------------------

$docs = @(

"Database_Architecture.md",
"Database_Normalization_Report.md",
"Data_Dictionary.md",
"Migration_History.md",
"Naming_Standards.md"

)

foreach ($file in $docs)
{
    $path = "database\documentation\$file"

    if(!(Test-Path $path))
    {
        New-Item -ItemType File -Path $path | Out-Null
    }
}

#----------------------------------------------------------
# Diagram Files
#----------------------------------------------------------

$diagrams = @(

"Master_ER_Diagram.drawio",
"Master_ER_Diagram.png",
"Master_ER_Diagram.pdf"

)

foreach ($file in $diagrams)
{
    $path = "database\diagrams\$file"

    if(!(Test-Path $path))
    {
        New-Item -ItemType File -Path $path | Out-Null
    }
}

#----------------------------------------------------------
# README Files
#----------------------------------------------------------

$readmeFiles = @(

"database\README.md",
"database\documentation\README.md",
"database\diagrams\README.md",
"database\seeds\README.md",
"database\views\README.md",
"database\procedures\README.md",
"database\functions\README.md",
"database\triggers\README.md"

)

foreach ($file in $readmeFiles)
{
    if(!(Test-Path $file))
    {
        New-Item -ItemType File -Path $file | Out-Null
    }
}

#----------------------------------------------------------
# GitKeep Files
#----------------------------------------------------------

$gitkeep = @(

"database\backups\.gitkeep"

)

foreach ($file in $gitkeep)
{
    if(!(Test-Path $file))
    {
        New-Item -ItemType File -Path $file | Out-Null
    }
}

Write-Host ""
Write-Host "Database Structure Created Successfully." -ForegroundColor Green
Write-Host ""
/******************************************************************************
 *
 * NCAS GRANT MANAGEMENT SYSTEM
 * --------------------------------------------
 * File          : 000_database_standards.sql
 * Version       : 1.0.0
 * Status        : Production
 * Database      : MySQL 8.x
 * Character Set : utf8mb4
 * Collation     : utf8mb4_unicode_ci
 * Engine         : InnoDB
 *
 * ----------------------------------------------------------------------------
 * PURPOSE
 * ----------------------------------------------------------------------------
 * This migration defines the official database development standards for the
 * NCAS Grant Management System.
 *
 * All future migrations MUST follow this standard.
 *
 * ----------------------------------------------------------------------------
 * MIGRATION ORDER
 * ----------------------------------------------------------------------------
 *
 * 000_database_standards.sql
 * 001_create_database.sql
 * 002_master_tables.sql
 * 003_user_management.sql
 * 004_applicant_module.sql
 * 005_interview_module.sql
 * 006_grant_module.sql
 * 007_payment_module.sql
 * 008_research_module.sql
 * 009_reports.sql
 * 010_views.sql
 * 011_stored_procedures.sql
 * 012_triggers.sql
 * 013_seed_data.sql
 * 014_initial_roles.sql
 * 015_initial_admin.sql
 *
 ******************************************************************************/

-- ============================================================================
-- DATABASE STANDARDS
-- ============================================================================

/*
------------------------------------------------------------------------------
1. MYSQL VERSION
------------------------------------------------------------------------------
MySQL 8.x or newer
*/

 /*
------------------------------------------------------------------------------
2. STORAGE ENGINE
------------------------------------------------------------------------------
All tables MUST use InnoDB.
*/

 /*
------------------------------------------------------------------------------
3. CHARACTER SET
------------------------------------------------------------------------------
utf8mb4
*/

 /*
------------------------------------------------------------------------------
4. COLLATION
------------------------------------------------------------------------------
utf8mb4_unicode_ci
*/

 /*
------------------------------------------------------------------------------
5. PRIMARY KEY STANDARD
------------------------------------------------------------------------------
Every table MUST have

<tablename>_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY

Example

user_id
grant_id
payment_id
*/

 /*
------------------------------------------------------------------------------
6. PUBLIC REFERENCE NUMBER
------------------------------------------------------------------------------
Never expose internal IDs.

Example

NCAS-GR-2026-000001

*/

 /*
------------------------------------------------------------------------------
7. AUDIT COLUMNS
------------------------------------------------------------------------------
Every business table MUST contain

created_at
created_by

updated_at
updated_by

deleted_at
deleted_by

is_deleted

*/

 /*
------------------------------------------------------------------------------
8. SOFT DELETE
------------------------------------------------------------------------------
Hard delete is NOT allowed.
*/

 /*
------------------------------------------------------------------------------
9. DATE/TIME
------------------------------------------------------------------------------
Store all datetime values in UTC.

Convert to Sri Lanka Time only in application layer.
*/

 /*
------------------------------------------------------------------------------
10. NAMING STANDARD
------------------------------------------------------------------------------

Tables

tbl_users
tbl_roles

Columns

user_id
role_id

Indexes

idx_username
idx_email

Unique Keys

uk_username
uk_email

Foreign Keys

fk_users_roles

Views

vw_active_users

Stored Procedures

sp_create_user

Functions

fn_generate_reference

Triggers

trg_users_before_insert

*/

 /*
------------------------------------------------------------------------------
11. INDEX STANDARD
------------------------------------------------------------------------------

Create indexes only where required.

Index

Username

Email

Public Reference Number

Foreign Keys

Search Columns

*/

 /*
------------------------------------------------------------------------------
12. MASTER DATA
------------------------------------------------------------------------------

Never Hardcode

Countries

Titles

Universities

Grant Types

Interview Status

Payment Status

Research Categories

Workflow Status

*/

 /*
------------------------------------------------------------------------------
13. WORKFLOW
------------------------------------------------------------------------------

Workflow MUST be database driven.

Never hardcode workflow in PHP.

*/

 /*
------------------------------------------------------------------------------
14. SECURITY
------------------------------------------------------------------------------

Passwords

bcrypt

Never store plaintext passwords.

*/

 /*
------------------------------------------------------------------------------
15. TRANSACTION
------------------------------------------------------------------------------

Financial operations

Grant approval

Payments

Research submission

must use SQL Transactions.

*/

 /*
------------------------------------------------------------------------------
16. AUDIT LOG
------------------------------------------------------------------------------

All critical operations MUST be logged.

*/

 /*
------------------------------------------------------------------------------
17. VERSIONING
------------------------------------------------------------------------------

Database Version

Schema Version

Migration Number

Release Number

must be maintained.

*/

 /*
------------------------------------------------------------------------------
18. CODING STANDARD
------------------------------------------------------------------------------

UPPERCASE SQL Keywords

snake_case identifiers

One statement per line

Meaningful comments

*/

 /*
------------------------------------------------------------------------------
19. CHANGE LOG
------------------------------------------------------------------------------

Version 1.0.0

Initial Enterprise Database Standards

*/

-- ============================================================================
-- END OF FILE
-- ============================================================================
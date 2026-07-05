/******************************************************************************
 *
 * NCAS GRANT MANAGEMENT SYSTEM
 * ============================================================================
 * Migration No : 002
 * File Name    : 002_master_tables.sql
 * Version      : 1.0.0
 * Status       : Production
 *
 * DESCRIPTION
 * ----------------------------------------------------------------------------
 * Master tables for system-wide reference data
 *
 ******************************************************************************/

START TRANSACTION;

USE ncas_grant_management;

-- ============================================================================
-- 1. COUNTRIES MASTER
-- ============================================================================
CREATE TABLE tbl_countries (
    country_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    country_code VARCHAR(10) NOT NULL,
    country_name VARCHAR(100) NOT NULL,

    is_active TINYINT(1) NOT NULL DEFAULT 1,

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100) NULL,
    updated_at DATETIME NULL,
    updated_by VARCHAR(100) NULL,
    deleted_at DATETIME NULL,
    deleted_by VARCHAR(100) NULL,
    is_deleted TINYINT(1) NOT NULL DEFAULT 0,

    UNIQUE KEY uk_country_code (country_code),
    UNIQUE KEY uk_country_name (country_name),
    INDEX idx_country_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 2. TITLES MASTER
-- ============================================================================
CREATE TABLE tbl_titles (
    title_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    title_name VARCHAR(50) NOT NULL,

    is_active TINYINT(1) NOT NULL DEFAULT 1,

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100) NULL,
    updated_at DATETIME NULL,
    updated_by VARCHAR(100) NULL,
    deleted_at DATETIME NULL,
    deleted_by VARCHAR(100) NULL,
    is_deleted TINYINT(1) NOT NULL DEFAULT 0,

    UNIQUE KEY uk_title_name (title_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 3. UNIVERSITIES MASTER
-- ============================================================================
CREATE TABLE tbl_universities (
    university_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    university_name VARCHAR(255) NOT NULL,
    country_id BIGINT UNSIGNED NOT NULL,

    is_active TINYINT(1) NOT NULL DEFAULT 1,

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100) NULL,
    updated_at DATETIME NULL,
    updated_by VARCHAR(100) NULL,
    deleted_at DATETIME NULL,
    deleted_by VARCHAR(100) NULL,
    is_deleted TINYINT(1) NOT NULL DEFAULT 0,

    UNIQUE KEY uk_university_name (university_name),
    INDEX idx_university_country (country_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 4. ACCOUNT STATUS MASTER
-- ============================================================================
CREATE TABLE tbl_account_statuses (
    account_status_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(50) NOT NULL,

    is_active TINYINT(1) NOT NULL DEFAULT 1,

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100) NULL,
    updated_at DATETIME NULL,
    updated_by VARCHAR(100) NULL,
    deleted_at DATETIME NULL,
    deleted_by VARCHAR(100) NULL,
    is_deleted TINYINT(1) NOT NULL DEFAULT 0,

    UNIQUE KEY uk_status_name (status_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
-- ============================================================================
-- 5. ROLES MASTER
-- ============================================================================
CREATE TABLE tbl_roles (
    role_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(100) NOT NULL,
    role_code VARCHAR(50) NOT NULL,

    is_system_role TINYINT(1) NOT NULL DEFAULT 0,
    is_active TINYINT(1) NOT NULL DEFAULT 1,

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100) NULL,
    updated_at DATETIME NULL,
    updated_by VARCHAR(100) NULL,
    deleted_at DATETIME NULL,
    deleted_by VARCHAR(100) NULL,
    is_deleted TINYINT(1) NOT NULL DEFAULT 0,

    UNIQUE KEY uk_role_code (role_code),
    UNIQUE KEY uk_role_name (role_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 6. PERMISSIONS MASTER
-- ============================================================================
CREATE TABLE tbl_permissions (
    permission_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    permission_name VARCHAR(150) NOT NULL,
    permission_code VARCHAR(100) NOT NULL,

    module_name VARCHAR(100) NOT NULL,

    is_active TINYINT(1) NOT NULL DEFAULT 1,

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100) NULL,
    updated_at DATETIME NULL,
    updated_by VARCHAR(100) NULL,
    deleted_at DATETIME NULL,
    deleted_by VARCHAR(100) NULL,
    is_deleted TINYINT(1) NOT NULL DEFAULT 0,

    UNIQUE KEY uk_permission_code (permission_code),
    INDEX idx_permission_module (module_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 7. WORKFLOW STATUSES MASTER
-- ============================================================================
CREATE TABLE tbl_workflow_statuses (
    workflow_status_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(100) NOT NULL,
    status_code VARCHAR(50) NOT NULL,

    module_name VARCHAR(100) NOT NULL,

    is_final_state TINYINT(1) NOT NULL DEFAULT 0,
    is_active TINYINT(1) NOT NULL DEFAULT 1,

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100) NULL,
    updated_at DATETIME NULL,
    updated_by VARCHAR(100) NULL,
    deleted_at DATETIME NULL,
    deleted_by VARCHAR(100) NULL,
    is_deleted TINYINT(1) NOT NULL DEFAULT 0,

    UNIQUE KEY uk_workflow_status_code (status_code),
    INDEX idx_workflow_module (module_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 8. GRANT TYPES MASTER
-- ============================================================================
CREATE TABLE tbl_grant_types (
    grant_type_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    grant_type_name VARCHAR(150) NOT NULL,
    grant_type_code VARCHAR(50) NOT NULL,

    is_active TINYINT(1) NOT NULL DEFAULT 1,

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100) NULL,
    updated_at DATETIME NULL,
    updated_by VARCHAR(100) NULL,
    deleted_at DATETIME NULL,
    deleted_by VARCHAR(100) NULL,
    is_deleted TINYINT(1) NOT NULL DEFAULT 0,

    UNIQUE KEY uk_grant_type_code (grant_type_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 9. INTERVIEW STATUSES MASTER
-- ============================================================================
CREATE TABLE tbl_interview_statuses (
    interview_status_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    status_name VARCHAR(100) NOT NULL,
    status_code VARCHAR(50) NOT NULL,

    is_active TINYINT(1) NOT NULL DEFAULT 1,

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100) NULL,
    updated_at DATETIME NULL,
    updated_by VARCHAR(100) NULL,
    deleted_at DATETIME NULL,
    deleted_by VARCHAR(100) NULL,
    is_deleted TINYINT(1) NOT NULL DEFAULT 0,

    UNIQUE KEY uk_interview_status_code (status_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
-- ============================================================================
-- 10. SEED DATA (INITIAL MASTER DATA)
-- ============================================================================

INSERT INTO tbl_countries (country_code, country_name, created_by)
VALUES
('LK', 'Sri Lanka', 'system'),
('IN', 'India', 'system'),
('US', 'United States', 'system');

INSERT INTO tbl_titles (title_name, created_by)
VALUES
('Mr', 'system'),
('Mrs', 'system'),
('Ms', 'system'),
('Dr', 'system'),
('Prof', 'system');

INSERT INTO tbl_account_statuses (status_name, created_by)
VALUES
('ACTIVE', 'system'),
('INACTIVE', 'system'),
('SUSPENDED', 'system');

INSERT INTO tbl_roles (role_name, role_code, created_by)
VALUES
('System Administrator', 'SYS_ADMIN', 'system'),
('Admin', 'ADMIN', 'system'),
('Reviewer', 'REVIEWER', 'system'),
('Applicant', 'APPLICANT', 'system');

INSERT INTO tbl_grant_types (grant_type_name, grant_type_code, created_by)
VALUES
('Research Grant', 'RESEARCH_GRANT', 'system'),
('Student Grant', 'STUDENT_GRANT', 'system'),
('Innovation Grant', 'INNOVATION_GRANT', 'system');

INSERT INTO tbl_interview_statuses (status_name, status_code, created_by)
VALUES
('PENDING', 'PENDING', 'system'),
('PASSED', 'PASSED', 'system'),
('FAILED', 'FAILED', 'system');

-- ============================================================================
-- 11. INDEX FINALIZATION CHECK
-- (All indexes already defined inline in table creation)
-- ============================================================================

-- ============================================================================
-- 12. VALIDATION QUERY (OPTIONAL)
-- ============================================================================

SELECT 'MASTER TABLES LOADED SUCCESSFULLY' AS status;

-- ============================================================================
-- COMMIT TRANSACTION
-- ============================================================================

COMMIT;

-- ============================================================================
-- END OF FILE
-- ============================================================================
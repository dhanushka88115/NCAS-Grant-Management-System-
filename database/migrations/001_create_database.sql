/******************************************************************************
 *
 * NCAS GRANT MANAGEMENT SYSTEM
 * ============================================================================
 * Migration No : 001
 * File Name    : 001_create_database.sql
 * Version      : 1.0.0
 * Database     : MySQL 8.x
 * Status       : Production
 *
 * DESCRIPTION
 * ----------------------------------------------------------------------------
 * Creates the NCAS Grant Management System database and schema version table.
 *
 ******************************************************************************/

-- ============================================================================
-- DATABASE SETTINGS
-- ============================================================================

SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;
SET collation_connection = 'utf8mb4_unicode_ci';

SET SQL_MODE='STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

SET time_zone = '+00:00';

-- ============================================================================
-- CREATE DATABASE
-- ============================================================================

CREATE DATABASE IF NOT EXISTS ncas_grant_management
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

USE ncas_grant_management;

-- ============================================================================
-- SCHEMA VERSION TABLE
-- ============================================================================

CREATE TABLE tbl_schema_versions (

    schema_version_id BIGINT UNSIGNED AUTO_INCREMENT,

    version_number VARCHAR(20) NOT NULL,

    migration_file VARCHAR(255) NOT NULL,

    description VARCHAR(500) NOT NULL,

    executed_by VARCHAR(100) NOT NULL,

    executed_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    execution_time_ms INT UNSIGNED NULL,

    checksum VARCHAR(128) NULL,

    success TINYINT(1) NOT NULL DEFAULT 1,

    remarks VARCHAR(1000) NULL,

    PRIMARY KEY (schema_version_id),

    UNIQUE KEY uk_version_number (version_number),

    UNIQUE KEY uk_migration_file (migration_file)

) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- INSERT INITIAL VERSION
-- ============================================================================

INSERT INTO tbl_schema_versions
(
    version_number,
    migration_file,
    description,
    executed_by,
    checksum,
    success
)
VALUES
(
    '1.0.0',
    '001_create_database.sql',
    'Initial NCAS Grant Management Database',
    CURRENT_USER(),
    NULL,
    1
);

-- ============================================================================
-- VERIFY
-- ============================================================================

SELECT
    DATABASE() AS database_name,
    VERSION() AS mysql_version;

-- ============================================================================
-- END OF FILE
-- ============================================================================
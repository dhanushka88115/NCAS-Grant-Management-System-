/******************************************************************************
 *
 * NCAS GRANT MANAGEMENT SYSTEM
 * ============================================================================
 * Migration No : 003
 * File Name    : 003_user_management.sql
 * Version      : 1.0.0
 * Status       : Production
 *
 * DESCRIPTION
 * ----------------------------------------------------------------------------
 * Core user management module
 * Includes authentication foundation, user identity and profile structure
 *
 ******************************************************************************/

START TRANSACTION;

USE ncas_grant_management;

-- ============================================================================
-- 1. USERS CORE TABLE
-- ============================================================================
CREATE TABLE tbl_users (

    user_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    username VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,

    public_reference_number VARCHAR(50) NOT NULL,

    account_status_id BIGINT UNSIGNED NOT NULL,

    email_verified TINYINT(1) NOT NULL DEFAULT 0,
    phone_verified TINYINT(1) NOT NULL DEFAULT 0,

    last_login_at DATETIME NULL,
    failed_login_attempts INT UNSIGNED NOT NULL DEFAULT 0,
    is_locked TINYINT(1) NOT NULL DEFAULT 0,

    is_active TINYINT(1) NOT NULL DEFAULT 1,
    is_deleted TINYINT(1) NOT NULL DEFAULT 0,

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100) NULL,

    updated_at DATETIME NULL,
    updated_by VARCHAR(100) NULL,

    deleted_at DATETIME NULL,
    deleted_by VARCHAR(100) NULL,

    -- CONSTRAINTS
    UNIQUE KEY uk_username (username),
    UNIQUE KEY uk_email (email),
    UNIQUE KEY uk_public_ref (public_reference_number),

    INDEX idx_user_status (account_status_id),
    INDEX idx_user_active (is_active),

    CONSTRAINT fk_users_account_status
        FOREIGN KEY (account_status_id)
        REFERENCES tbl_account_statuses(account_status_id)

) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;

-- ============================================================================
-- 2. USER PROFILES TABLE
-- ============================================================================
CREATE TABLE tbl_user_profiles (

    user_profile_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    user_id BIGINT UNSIGNED NOT NULL,

    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,

    title_id BIGINT UNSIGNED NULL,
    country_id BIGINT UNSIGNED NULL,
    university_id BIGINT UNSIGNED NULL,

    date_of_birth DATE NULL,
    gender VARCHAR(20) NULL,
    phone_number VARCHAR(30) NULL,
    address TEXT NULL,

    profile_picture VARCHAR(255) NULL,

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100) NULL,

    updated_at DATETIME NULL,
    updated_by VARCHAR(100) NULL,

    deleted_at DATETIME NULL,
    deleted_by VARCHAR(100) NULL,

    is_deleted TINYINT(1) NOT NULL DEFAULT 0,

    UNIQUE KEY uk_user_profile (user_id),

    INDEX idx_profile_country (country_id),
    INDEX idx_profile_university (university_id),

    CONSTRAINT fk_profile_user
        FOREIGN KEY (user_id)
        REFERENCES tbl_users(user_id),

    CONSTRAINT fk_profile_title
        FOREIGN KEY (title_id)
        REFERENCES tbl_titles(title_id),

    CONSTRAINT fk_profile_country
        FOREIGN KEY (country_id)
        REFERENCES tbl_countries(country_id),

    CONSTRAINT fk_profile_university
        FOREIGN KEY (university_id)
        REFERENCES tbl_universities(university_id)

) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;
/* ============================================================================
 * 3. USER LOGIN HISTORY
 * ============================================================================ */

CREATE TABLE tbl_user_login_history (

    login_history_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    user_id BIGINT UNSIGNED NOT NULL,

    login_time DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    logout_time DATETIME NULL,

    login_ip VARCHAR(45) NULL,
    user_agent TEXT NULL,

    login_status VARCHAR(20) NOT NULL, 
    -- SUCCESS / FAILED

    failure_reason VARCHAR(255) NULL,

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    INDEX idx_login_user (user_id),
    INDEX idx_login_time (login_time),

    CONSTRAINT fk_login_history_user
        FOREIGN KEY (user_id)
        REFERENCES tbl_users(user_id)

) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;


/* ============================================================================
 * 4. USER PASSWORD HISTORY
 * ============================================================================ */

CREATE TABLE tbl_user_password_history (

    password_history_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    user_id BIGINT UNSIGNED NOT NULL,

    password_hash VARCHAR(255) NOT NULL,

    changed_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    changed_reason VARCHAR(255) NULL,

    INDEX idx_password_user (user_id),

    CONSTRAINT fk_password_history_user
        FOREIGN KEY (user_id)
        REFERENCES tbl_users(user_id)

) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;


/* ============================================================================
 * 5. USER SESSIONS
 * ============================================================================ */

CREATE TABLE tbl_user_sessions (

    session_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    user_id BIGINT UNSIGNED NOT NULL,

    session_token VARCHAR(255) NOT NULL,

    ip_address VARCHAR(45) NULL,
    user_agent TEXT NULL,

    expires_at DATETIME NOT NULL,
    is_active TINYINT(1) NOT NULL DEFAULT 1,

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    INDEX idx_session_user (user_id),
    INDEX idx_session_token (session_token),

    CONSTRAINT fk_session_user
        FOREIGN KEY (user_id)
        REFERENCES tbl_users(user_id)

) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;
/* ============================================================================
 * 6. AUDIT LOGS (ENTERPRISE CORE)
 * ============================================================================ */

CREATE TABLE tbl_audit_logs (

    audit_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    user_id BIGINT UNSIGNED NULL,

    action_type VARCHAR(100) NOT NULL,
    -- INSERT / UPDATE / DELETE / LOGIN / LOGOUT / APPROVE / REJECT

    table_name VARCHAR(100) NOT NULL,
    record_id BIGINT UNSIGNED NULL,

    old_values JSON NULL,
    new_values JSON NULL,

    ip_address VARCHAR(45) NULL,
    user_agent TEXT NULL,

    action_time DATETIME DEFAULT CURRENT_TIMESTAMP,

    INDEX idx_audit_user (user_id),
    INDEX idx_audit_table (table_name),
    INDEX idx_audit_time (action_time),

    CONSTRAINT fk_audit_user
        FOREIGN KEY (user_id)
        REFERENCES tbl_users(user_id)

) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;


/* ============================================================================
 * 7. USER ROLE ASSIGNMENT
 * ============================================================================ */

CREATE TABLE tbl_user_roles (

    user_role_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    user_id BIGINT UNSIGNED NOT NULL,
    role_id BIGINT UNSIGNED NOT NULL,

    assigned_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    assigned_by VARCHAR(100) NULL,

    is_active TINYINT(1) NOT NULL DEFAULT 1,

    UNIQUE KEY uk_user_role (user_id, role_id),

    INDEX idx_user_role_user (user_id),
    INDEX idx_user_role_role (role_id),

    CONSTRAINT fk_user_roles_user
        FOREIGN KEY (user_id)
        REFERENCES tbl_users(user_id),

    CONSTRAINT fk_user_roles_role
        FOREIGN KEY (role_id)
        REFERENCES tbl_roles(role_id)

) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;


/* ============================================================================
 * 8. USER NOTIFICATIONS
 * ============================================================================ */

CREATE TABLE tbl_user_notifications (

    notification_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    user_id BIGINT UNSIGNED NOT NULL,

    title VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,

    is_read TINYINT(1) NOT NULL DEFAULT 0,

    notification_type VARCHAR(50) NULL,
    -- INFO / WARNING / SUCCESS / ERROR

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    INDEX idx_notification_user (user_id),
    INDEX idx_notification_read (is_read),

    CONSTRAINT fk_notification_user
        FOREIGN KEY (user_id)
        REFERENCES tbl_users(user_id)

) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;
/* ============================================================================
 * 9. PASSWORD RESET TOKENS
 * ============================================================================ */

CREATE TABLE tbl_password_reset_tokens (

    token_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    user_id BIGINT UNSIGNED NOT NULL,

    token VARCHAR(255) NOT NULL,

    expires_at DATETIME NOT NULL,

    is_used TINYINT(1) NOT NULL DEFAULT 0,

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    INDEX idx_reset_user (user_id),
    INDEX idx_reset_token (token),

    CONSTRAINT fk_reset_user
        FOREIGN KEY (user_id)
        REFERENCES tbl_users(user_id)

) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;


/* ============================================================================
 * 10. ACCOUNT SECURITY POLICIES
 * ============================================================================ */

CREATE TABLE tbl_account_security_policies (

    policy_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    policy_name VARCHAR(150) NOT NULL,

    max_login_attempts INT NOT NULL DEFAULT 5,
    lock_duration_minutes INT NOT NULL DEFAULT 30,

    password_expiry_days INT NOT NULL DEFAULT 90,
    password_min_length INT NOT NULL DEFAULT 8,

    require_special_char TINYINT(1) NOT NULL DEFAULT 1,
    require_number TINYINT(1) NOT NULL DEFAULT 1,
    require_uppercase TINYINT(1) NOT NULL DEFAULT 1,

    is_active TINYINT(1) NOT NULL DEFAULT 1,

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100) NULL,

    updated_at DATETIME NULL,
    updated_by VARCHAR(100) NULL,

    UNIQUE KEY uk_policy_name (policy_name)

) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;


/* ============================================================================
 * 11. ACCOUNT LOCK HISTORY
 * ============================================================================ */

CREATE TABLE tbl_account_lock_history (

    lock_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,

    user_id BIGINT UNSIGNED NOT NULL,

    lock_reason VARCHAR(255) NOT NULL,
    locked_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    unlocked_at DATETIME NULL,

    locked_by VARCHAR(100) NULL,
    unlocked_by VARCHAR(100) NULL,

    is_active TINYINT(1) NOT NULL DEFAULT 1,

    INDEX idx_lock_user (user_id),

    CONSTRAINT fk_lock_user
        FOREIGN KEY (user_id)
        REFERENCES tbl_users(user_id)

) ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci;
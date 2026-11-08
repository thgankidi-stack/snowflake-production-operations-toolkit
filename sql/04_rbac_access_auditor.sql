
-- Snowflake RBAC Access Auditor
-- Read-only privilege review
-- Direct grants only; inherited grants not expanded

SELECT
    grantee_name AS role_name,
    granted_on AS object_type,
    name AS object_name,
    privilege,
    grant_option,
    granted_by,
    created_on
FROM SNOWFLAKE.ACCOUNT_USAGE.GRANTS_TO_ROLES
WHERE deleted_on IS NULL
  AND granted_to = 'ACCOUNT ROLE'
  AND (
      privilege IN (
          'OWNERSHIP',
          'MANAGE GRANTS',
          'CREATE USER',
          'CREATE ROLE'
      )
      OR grant_option = TRUE
  )
ORDER BY
    role_name,
    object_type,
    object_name,
    privilege;

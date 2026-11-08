
-- Expensive Query Investigator
-- Runtime is not a direct measure of credit cost

SELECT
    query_id,
    start_time,
    warehouse_name,
    user_name,
    query_type,
    ROUND(total_elapsed_time / 1000.0, 2)
        AS elapsed_seconds,
    ROUND(execution_time / 1000.0, 2)
        AS execution_seconds,
    ROUND(bytes_scanned / POWER(1024, 3), 2)
        AS scanned_gb,
    ROUND(
        bytes_spilled_to_remote_storage / POWER(1024, 3),
        2
    ) AS remote_spill_gb,
    ROUND(queued_overload_time / 1000.0, 2)
        AS queue_seconds,
    query_hash
FROM SNOWFLAKE.ACCOUNT_USAGE.QUERY_HISTORY
WHERE start_time >= DATEADD(day, -7, CURRENT_TIMESTAMP())
  AND execution_status = 'success'
  AND warehouse_name IS NOT NULL
ORDER BY total_elapsed_time DESC
LIMIT 50;


-- Snowflake Task Failure Analyzer
-- Historical task execution analysis

SELECT
    database_name,
    schema_name,
    name AS task_name,
    COUNT(*) AS total_runs,
    COUNT_IF(state = 'FAILED') AS failed_runs,
    ROUND(
        100.0 * COUNT_IF(state = 'FAILED')
        / NULLIF(COUNT(*), 0),
        2
    ) AS failure_pct,
    MAX(
        IFF(state = 'FAILED', scheduled_time, NULL)
    ) AS latest_failure_time,
    MAX_BY(
        IFF(state = 'FAILED', error_message, NULL),
        IFF(state = 'FAILED', scheduled_time, NULL)
    ) AS latest_failure_message
FROM SNOWFLAKE.ACCOUNT_USAGE.TASK_HISTORY
WHERE scheduled_time >= DATEADD(day, -30, CURRENT_TIMESTAMP())
  AND state IN (
      'SUCCEEDED',
      'FAILED',
      'CANCELLED',
      'SKIPPED'
  )
GROUP BY 1, 2, 3
HAVING COUNT_IF(state = 'FAILED') > 0
ORDER BY failed_runs DESC, latest_failure_time DESC;

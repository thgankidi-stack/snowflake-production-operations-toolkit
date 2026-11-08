
-- Snowflake Cortex AI Functions Usage Monitor
-- Cortex AI Functions only
-- Historical usage from 2026-01-05 onward

SELECT
    DATE_TRUNC('day', start_time) AS usage_day,
    function_name,
    model_name,
    ROUND(SUM(credits), 4)
        AS ai_function_credits,
    COUNT(DISTINCT query_id)
        AS distinct_queries,
    COUNT(*) AS usage_records
FROM SNOWFLAKE.ACCOUNT_USAGE.CORTEX_AI_FUNCTIONS_USAGE_HISTORY
WHERE start_time >= DATEADD(day, -30, CURRENT_TIMESTAMP())
  AND is_completed = TRUE
GROUP BY 1, 2, 3
ORDER BY
    usage_day DESC,
    ai_function_credits DESC;

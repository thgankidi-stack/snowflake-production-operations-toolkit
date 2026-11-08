
-- Warehouse Credit Spike Detective
-- Read-only | Historical compute credit analysis
-- Minimum baseline: 3 observations

WITH hourly AS (
    SELECT
        warehouse_name,
        start_time,
        DATE_PART('hour', start_time) AS hour_of_day,
        credits_used_compute AS compute_credits
    FROM SNOWFLAKE.ACCOUNT_USAGE.WAREHOUSE_METERING_HISTORY
    WHERE start_time >= DATEADD(day, -21, CURRENT_TIMESTAMP())
      AND start_time < DATEADD(hour, -6, CURRENT_TIMESTAMP())
),
scored AS (
    SELECT
        warehouse_name,
        start_time,
        compute_credits,
        AVG(compute_credits) OVER (
            PARTITION BY warehouse_name, hour_of_day
            ORDER BY DATE_PART(epoch_second, start_time)
            RANGE BETWEEN 1209600 PRECEDING AND 1 PRECEDING
        ) AS baseline_credits,
        COUNT(*) OVER (
            PARTITION BY warehouse_name, hour_of_day
            ORDER BY DATE_PART(epoch_second, start_time)
            RANGE BETWEEN 1209600 PRECEDING AND 1 PRECEDING
        ) AS baseline_observations
    FROM hourly
)
SELECT
    warehouse_name,
    start_time,
    ROUND(compute_credits, 3) AS compute_credits,
    ROUND(baseline_credits, 3) AS baseline_credits,
    ROUND(
        compute_credits / NULLIF(baseline_credits, 0), 2
    ) AS spike_ratio
FROM scored
WHERE start_time >= DATEADD(day, -7, CURRENT_TIMESTAMP())
  AND baseline_observations >= 3
  AND baseline_credits > 0
  AND compute_credits >= baseline_credits * 2
ORDER BY spike_ratio DESC, start_time DESC;

# Snowflake Production Operations Toolkit

Practical SQL-based monitoring and troubleshooting examples for Snowflake data engineering and platform operations.

This open-source toolkit provides reusable SQL queries to investigate warehouse credit consumption, query performance, task execution failures, role-based access control (RBAC), and Cortex AI usage.

The repository includes both **production monitoring queries** and **synthetic demo datasets**, allowing Snowflake users to explore the examples even when their accounts have limited activity history.

## Features

| Feature | Description |
|---|---|
| Warehouse Credit Spike Detective | Detect unusual warehouse compute credit consumption using historical baselines |
| Expensive Query Investigator | Identify slow queries, excessive scanning, remote spilling, and queueing |
| Task Failure Analyzer | Investigate recurring Snowflake task failures and execution trends |
| RBAC Access Auditor | Review sensitive direct role grants and elevated permissions |
| Cortex AI Usage Monitor | Analyze historical Cortex AI Functions consumption and usage trends |

## Repository Structure

```text
snowflake-production-operations-toolkit/
├── README.md
├── LICENSE
├── sql/
│   ├── 01_warehouse_credit_spikes.sql
│   ├── 02_expensive_query_investigator.sql
│   ├── 03_task_failure_analyzer.sql
│   ├── 04_rbac_access_auditor.sql
│   └── 05_cortex_ai_usage_monitor.sql
├── demo/
│   ├── 00_create_demo_tables.sql
│   ├── 01_generate_sample_data.sql
│   └── 02_run_demo_queries.sql
└── screenshots/
```

## Prerequisites

- An active Snowflake account, including a trial account
- Access to Snowsight SQL Worksheets
- A warehouse available for executing queries
- Permission to create a database, schema, and tables for the demo
- Appropriate access to `SNOWFLAKE.ACCOUNT_USAGE` views for production monitoring

The demo does not require historical Account Usage records.

## Getting Started

### Option A: Run with Synthetic Demo Data

This option is recommended for trial accounts or users who want to reproduce the sample results immediately.

1. Open Snowflake Snowsight and create a SQL worksheet.
2. Select a role with permission to create database objects.
3. Run `demo/00_create_demo_tables.sql`.
4. Run `demo/01_generate_sample_data.sql`.
5. Run `demo/02_run_demo_queries.sql`.
6. Review the generated monitoring results.

The demo creates fictional monitoring records, including warehouse credit spikes, slow queries, failed tasks, privileged role grants, and Cortex AI usage.

### Option B: Run Against Actual Snowflake Account History

1. Open a SQL worksheet.
2. Select a role with access to the required Account Usage views.
3. Open the relevant script from the `sql/` folder.
4. Execute the query.
5. Review the results and adjust the date range or thresholds as needed.

The production scripts are read-only and do not modify account objects.

## Monitoring Examples

### 1. Warehouse Credit Spike Detective

Compares hourly warehouse compute consumption against historical usage for the same hour of day.

**Use cases:**
- Investigating unexpected compute credit increases
- Identifying unusual warehouse activity
- Supporting cost optimization investigations

The baseline is a heuristic and may require adjustment for seasonality, irregular workloads, or new warehouses.

### 2. Expensive Query Investigator

Identifies queries with long execution times, significant data scanning, remote disk spilling, or queueing delays.

**Use cases:**
- Performance troubleshooting
- Query tuning investigations
- Identifying warehouse resource pressure

Query duration is not equivalent to actual query-level credit cost.

### 3. Task Failure Analyzer

Summarizes failed Snowflake task executions and recurring error patterns.

**Use cases:**
- Data pipeline monitoring
- Investigating recurring task failures
- Supporting DataOps incident analysis

### 4. RBAC Access Auditor

Identifies sensitive direct role grants and permissions requiring review.

**Use cases:**
- Security assessments
- Privileged access reviews
- Governance and compliance support

The query does not recursively expand inherited permissions or automatically determine whether access is inappropriate.

### 5. Cortex AI Usage Monitor

Summarizes available Cortex AI Functions usage records and historical credit consumption.

**Use cases:**
- Monitoring AI workload consumption
- Investigating changes in AI usage
- Supporting AI cost governance

This script does not represent all Cortex services or total Snowflake AI spending.

## Demo Dataset

The synthetic dataset contains approximately:

| Dataset | Records |
|---|---:|
| Warehouse usage | 1,512 |
| Query history | 200 |
| Task history | 60 |
| RBAC grants | 5 |
| Cortex AI usage | 80 |

All demo records, users, roles, workloads, and credit amounts are fictional. They do not represent actual account activity or billing.

## Screenshots

Add screenshots of successfully executed queries to the `screenshots/` directory.

Recommended screenshots include:
- Warehouse credit spike results
- Expensive query investigation
- Task failure analysis
- RBAC privilege review
- Cortex AI consumption trends

Screenshots should contain only synthetic or appropriately sanitized information.

## Important Limitations

- Account Usage views may have reporting latency.
- Availability and retention differ across metadata views.
- Some views require additional privileges.
- Cortex AI usage schemas and supported features may change.
- Synthetic demo data should not be interpreted as actual Snowflake consumption.
- Queries are intended as educational and operational starting points, not complete monitoring or security solutions.
- Test all scripts in your environment before production use.

## Future Enhancements

Planned opportunities for improvement include:

- Streamlit monitoring dashboards
- Configurable anomaly detection thresholds
- Automated monitoring tasks and notifications
- Additional warehouse cost investigation patterns
- Extended RBAC role hierarchy analysis
- Data quality and ingestion monitoring

These enhancements are not included in the current release.

## Contributing

Contributions, bug reports, improvements, and additional monitoring examples are welcome.

To contribute:

1. Fork the repository.
2. Create a feature branch.
3. Make and test your changes.
4. Submit a pull request describing the improvement.

Please do not submit credentials, confidential data, customer information, or unredacted production logs.

## License

Distributed under the MIT License. See the `LICENSE` file for details.

## Disclaimer

This is an independent, community-created project. It is not an official Snowflake product and is not endorsed, sponsored, or maintained by Snowflake Inc.

Snowflake and related product names are trademarks of their respective owners.

The scripts are provided as-is without warranty. Users are responsible for validating suitability, permissions, security, performance, and cost implications in their own environments.

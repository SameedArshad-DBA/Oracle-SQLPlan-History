INSERT INTO sql_plan_history (
    sql_id,
    plan_hash_value,
    child_number,
    timestamp,
    operation,
    options,
    object_name,
    object_owner,
    object_type,
    depth,
    cost,
    cardinality,
    bytes,
    cpu_cost_plan,
    io_cost_plan,
    projection,
    time,
    parse_calls,
    disk_reads,
    direct_writes,
    direct_reads,
    buffer_gets,
    rows_processed,
    fetches,
    cpu_time_stats,
    elapsed_time_stats
)
SELECT
    p.sql_id,
    p.plan_hash_value,
    p.child_number,
    p.timestamp,
    p.operation,
    p.options,
    p.object_name,
    p.object_owner,
    p.object_type,
    p.depth,
    p.cost,
    p.cardinality,
    p.bytes,
    p.cpu_cost,
    p.io_cost,
    p.projection,
    p.time,
    s.parse_calls,
    s.disk_reads,
    s.direct_writes,
    s.direct_reads,
    s.buffer_gets,
    s.rows_processed,
    s.fetches,
    s.cpu_time,
    s.elapsed_time
FROM
    v$sqlstats_plan_all p
JOIN
    v$sqlstats s
ON  p.sql_id = s.sql_id
AND p.plan_hash_value = s.plan_hash_value
AND p.child_number = s.child_number;
WHERE
    /* --- QUALIFICATION CRITERIA --- */
    (s.buffer_gets > 100000
        OR s.cpu_time > 50000000	 --50 secs
        OR s.elapsed_time > 1000000)     -- 1 sec
    AND s.executions > 2                 -- must be repeatable
    AND s.plan_hash_value IS NOT NULL
    --AND s.command_type NOT IN (0,47,170)
    AND s.parsing_schema_name NOT IN ('SYS','SYSTEM')

    /* --- Capture only if plan FLIPPED --- */
    AND NOT EXISTS (
        SELECT 1
        FROM plan_history h
        WHERE h.sql_id = s.sql_id
          AND h.plan_hash_value = s.plan_hash_value
    );

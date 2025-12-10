CREATE TABLE sql_plan_history (
    -- From v$sqlstats_plan_all
    sql_id              VARCHAR2(13),
    plan_hash_value     NUMBER,
    child_number        NUMBER,
    timestamp           DATE,
    operation           VARCHAR2(120),
    options             VARCHAR2(120),
    object_name         VARCHAR2(128),
    object_owner        VARCHAR2(128),
    object_type         VARCHAR2(80),
    depth               NUMBER,
    cost                NUMBER,
    cardinality         NUMBER,
    bytes               NUMBER,
    cpu_cost_plan       NUMBER,
    io_cost_plan        NUMBER,
    projection          VARCHAR2(4000),
    time                VARCHAR2(4000),
    -- From v$sqlstats
    parse_calls         NUMBER,
    disk_reads          NUMBER,
    direct_writes       NUMBER,
    direct_reads        NUMBER,
    buffer_gets         NUMBER,
    rows_processed      NUMBER,
    fetches             NUMBER,
    cpu_time_stats      NUMBER,
    elapsed_time_stats  NUMBER
    
    CONSTRAINT sqlid_pk PRIMARY KEY (sql_id)
);

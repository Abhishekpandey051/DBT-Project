WITH dedup_query AS
(
SELECT 
*,
ROW_NUMBER() OVER (PARTITION BY id ORDER BY updateDate DESC) AS deduped_id
FROM {{ source('source', 'items') }}
)
SELECT 
    id,
    name,
    category,
    updateDate
  FROM dedup_query
  WHERE deduped_id = 1  
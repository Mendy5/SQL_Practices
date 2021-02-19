WITH RECURSIVE employee_chain AS (
  SELECT
    id,
    first_name,
    last_name,
    first_name || ' ' || last_name AS chain
  FROM employee
  WHERE manager_id IS NULL
  UNION ALL
  SELECT
    employee.id,
    employee.first_name,
    employee.last_name,
    chain || '->' || employee.first_name || ' ' || employee.last_name
  FROM employee_chain
  JOIN employee
    ON employee.manager_id = employee_chain.id
)

SELECT
  first_name,
  last_name,
  chain
FROM employee_chain;

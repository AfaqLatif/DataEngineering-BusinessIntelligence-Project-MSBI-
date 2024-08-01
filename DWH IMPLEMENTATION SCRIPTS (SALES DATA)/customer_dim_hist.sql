
-- CREATE TABLE customer_dim (
--    customer_key INT IDENTITY(1, 1) PRIMARY KEY,
--    customer_id INT,
--    customer_name VARCHAR(255),
--    address VARCHAR(255),
--    valid_from_date DATE,
--    valid_to_date DATE,
--    is_current_flag BIT
-- );

-- select * from customers;

-- select * from customer_dim;

-- truncate table customer_dim;

--update customers
--set state = 'LA'
--where customerNumber = 112
--;

MERGE customer_dim AS t
USING (
    select 
 customerNumber,
 customerName,
 state,
 GETDATE() as valid_from_date
from customers
) AS s
ON t.customer_id = s.customerNumber
WHEN MATCHED AND T.ADDRESS <> s.state THEN
    UPDATE SET
        t.valid_to_date = DATEADD(DAY,-1,s.valid_from_date),
        t.is_current_flag = 0
WHEN NOT MATCHED THEN
    INSERT (customer_id, customer_name, address, valid_from_date, valid_to_date, is_current_flag)
    VALUES (s.customerNumber, s.customerName, s.state, s.valid_from_date, '9999-12-31', 1)
;

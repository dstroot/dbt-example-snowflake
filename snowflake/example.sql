/*
Purpose: query the customers view to see our customer's lifetime value 
and the last time they place an order. We want to create a campaign
to send coupons to our best customers that haven't ordered in a while.
*/

SELECT
    customer_id,
    first_order,
    most_recent_order,
    number_of_orders,
    customer_lifetime_value
FROM
    customers
WHERE
    customer_lifetime_value > 0
    AND number_of_orders >= 1
ORDER BY
    customer_lifetime_value DESC
LIMIT
    100;
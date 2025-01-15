use bike_rental;

-- Question 1

SELECT
category,
COUNT(id) AS number_of_bikes
FROM bike
GROUP BY 1
HAVING COUNT(id) > 2;

-- Question 2

SELECT 
customer.name,
COUNT(membership.id) AS membership_count
FROM customer
LEFT JOIN
membership
ON customer.id = membership.customer_id
GROUP BY 1
ORDER BY COUNT(membership.id) DESC;

-- Question 3

SELECT 
id,
category,
price_per_hour AS old_price_per_hour,
CASE WHEN category = 'electric' THEN price_per_hour * 0.9
     WHEN category = 'mountain bike' THEN price_per_hour * 0.8
     ELSE price_per_hour * 0.5
     END AS new_price_per_hour,         
price_per_day AS old_price_per_day,
CASE WHEN category = 'electric' THEN price_per_day * 0.8
     WHEN category = 'mountain bike' THEN price_per_day * 0.5
     ELSE price_per_day * 0.5
     END AS new_price_per_day 
FROM bike;

-- Question 4

SELECT
category,
COUNT(CASE WHEN status = 'available' THEN id ELSE NULL END) AS available_bikes_count,
COUNT(CASE WHEN status = 'rented' THEN id ELSE NULL END) AS rented_bikes_count
FROM bike
GROUP BY 1;

-- Question 5

SELECT
YEAR(start_timestamp) AS 'year',
MONTH(start_timestamp) AS 'month',
SUM(total_paid) AS revenue
FROM rental
GROUP BY 1,2;

-- Question 6

SELECT 
YEAR(membership.start_date) AS yr,
MONTH(membership.start_date) AS mo,
membership_type.name AS membership_type_name,
SUM(membership.total_paid) AS revenue
FROM membership
LEFT JOIN membership_type
ON membership.membership_type_id = membership_type.id
GROUP BY 1,2,3
ORDER BY 1,2,3;

-- Question 7

SELECT
MONTH(membership.start_date) AS mo,
membership_type.name AS membership_type_name,
SUM(membership.total_paid) AS total_revenue
FROM membership
LEFT JOIN membership_type
ON membership.membership_type_id = membership_type.id
GROUP BY 1,2
ORDER BY 2,1;

-- Question 8


SELECT
rental_count_category,
COUNT(customer_id) AS total_rentals
FROM(
SELECT
customer_id,
COUNT(id) as total_rentals,
CASE WHEN COUNT(id) > 10 THEN 'more than 10' 
	 WHEN COUNT(id) BETWEEN 5 AND 10 THEN 'between 5 and 10'
     ELSE 'fewer than 5'
     END AS rental_count_category
FROM rental
GROUP BY 1) AS rental_table
GROUP BY 1
ORDER BY total_rentals;
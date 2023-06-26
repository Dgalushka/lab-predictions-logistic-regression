USE sakila;

SELECT distinct(special_features) FROM FILM;

-- STEP 1, created CTE to count rentals per film_id,
-- STEP 2,  JOINED all the other columns to get the information i thought would be useful to have in the data sample
-- STEP 3, devided the query into 2 parts, using CASE/WHEN and WHERE to filter the rows with films rented 15 times and less and more than 15 times
-- PS. of course, there were multiple steps before that to get to conclusion that i would need the final 3 steps that i have mentioned

-- rented less than 15

WITH cte_times_rented AS (
	SELECT film_id, count(distinct rental_id) AS Times_Rented FROM sakila.rental
	JOIN sakila.inventory i USING(inventory_id)
	GROUP BY film_id
)
SELECT Film_id, Times_rented, 
	CASE WHEN Times_rented <= 15 
	THEN 'Fifteen and less' 
    END AS Rental_Popularity,
f.Rental_Duration, f.Length, f.Replacement_Cost, f.Rating, f.Special_Features, c.name AS Category_Name
FROM cte_times_rented 
JOIN sakila.film f USING (film_id)
JOIN sakila.film_category fc USING (film_id)
JOIN sakila.category c USING (category_id)
WHERE Times_rented <= 15;

-- rented more than 15

WITH cte_times_rented AS (
	SELECT film_id, count(distinct rental_id) AS Times_Rented FROM sakila.rental
	JOIN sakila.inventory i USING(inventory_id)
	GROUP BY film_id
)
SELECT Film_id, Times_rented, 
	CASE WHEN Times_rented > 15 
	THEN 'More than fifteen' 
    END AS Rental_Popularity,
f.Rental_Duration, f.Length, f.Replacement_Cost, f.Rating, f.Special_Features, c.name AS Category_Name
FROM cte_times_rented 
JOIN sakila.film f USING (film_id)
JOIN sakila.film_category fc USING (film_id)
JOIN sakila.category c USING (category_id)
WHERE Times_rented > 15;



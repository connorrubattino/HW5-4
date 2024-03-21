--1. Create a Stored Procedure that will insert a new film into the film table with the
--following arguments: title, description, release_year, language_id, rental_duration,
--rental_rate, length, replace_cost, rating

SELECT *
FROM film;




CREATE OR REPLACE PROCEDURE add_film(title VARCHAR, description TEXT, release_year YEAR, language_id INT2, rental_duration INT2, rental_rate NUMERIC(4,2), "length" INT2, replacement_cost NUMERIC(5,2), rating public.mpaa_rating)
LANGUAGE plpgsql
AS $$
BEGIN 
	INSERT INTO film(title, description, release_year, language_id, rental_duration, rental_rate, "length", replacement_cost, rating)
	VALUES(title, description, release_year, language_id, rental_duration, rental_rate, "length", replacement_cost, rating);
END;
$$;




--not letting me execute without including the datatype not sure why exactly

CALL add_film('The Example'::VARCHAR, 'Trials and tribulations of trying to add in films'::TEXT, 2024::YEAR, 1::INT2, 5::INT2, 7.99::NUMERIC, 98::INT2, 25.99::NUMERIC, 'R'::public.mpaa_rating);

CALL add_film('Coding Templars'::VARCHAR, 'Fighting our way through code'::TEXT, 2024::YEAR, 1::INT2, 5::INT2, 9.99::NUMERIC, 128::INT2, 15.99::NUMERIC, 'PG-13'::public.mpaa_rating);



SELECT *
FROM film
ORDER BY release_year DESC;







--2. Create a Stored Function that will take in a category_id and return the number of
--films in that category

CREATE OR REPLACE FUNCTION get_film_count(ID INTEGER)
RETURNS INTEGER
LANGUAGE plpgsql
AS $$
	DECLARE film_count INTEGER;
BEGIN
	SELECT count(*) INTO film_count
	FROM film f
	JOIN film_category fc
	ON f.film_id = fc.film_id
	JOIN category c
	ON fc.category_id = c.category_id
	WHERE c.category_id = ID;
	RETURN film_count;
END;
$$;

SELECT get_film_count(2);
SELECT get_film_count(1);


SELECT *
FROM film_category fc 
ORDER BY category_id;
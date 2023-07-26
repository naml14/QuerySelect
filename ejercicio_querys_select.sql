/*Selecciona las columnas film_id y title de la tabla film.*/
SELECT film_id,title FROM film;

/*Selecciona 5 filas de la tabla film, obteniendo todas las columnas.*/
SELECT * FROM film LIMIT 5;

/*Selecciona filas de la tabla film donde film_id sea menor que 4.*/
SELECT * FROM film WHERE film_id<4;

/*Selecciona filas de la tabla film donde el rating sea PG o G.*/
SELECT * FROM film WHERE rating='G' OR rating='PG';

/*Obtenga una lista de actores con el nombre de Julia*/
SELECT * FROM actor WHERE first_name='Julia';

/*Obtenga una lista de actores con el nombre Chris, Cameron o Cuba*/
SELECT * FROM actor WHERE first_name='Chris' OR first_name='Cameron' OR first_name='Cuba';

/*Selecciona filas de la tabla actor donde el nombre sea Angela, Angelina o Audrey usando IN.*/
SELECT * FROM actor WHERE first_name IN ('Angela','Angelina','Audrey');

/*Seleccione la fila del cliente para el cliente llamado Jamie Rice*/
SELECT * FROM customer WHERE first_name='Jamie' AND last_name='Rice';

/*Selecciona el monto y la fecha de pago de la tabla payment donde el monto pagado sea menor a $1*/
SELECT amount,payment_date FROM payment WHERE amount<1;

/*Ordena las filas en la tabla city por country_id y luego por city.*/
SELECT * FROM city ORDER BY country_id, city;

/*¿Cuántas películas tienen la clasificación NC-17?*/
SELECT COUNT(rating) FROM film WHERE rating='NC-17';
/*210*/

/*¿Cuántas están clasificadas como PG o PG-13?*/
SELECT COUNT(rating) FROM film WHERE rating='PG-13' OR rating='PG';
/*417*/

/*¿Cuántos clientes diferentes tienen registros en la tabla rental?*/
SELECT COUNT (DISTINCT customer_id) FROM rental;
/*599*/

/*¿Hay algún cliente con el mismo apellido?*/
SELECT last_name,COUNT (last_name) FROM customer GROUP BY last_name HAVING COUNT (last_name) > 1;
/*No hay*/

/*¿Cuáles son los ID de los últimos 3 clientes que devolvieron un alquiler?*/
SELECT customer_id FROM rental ORDER BY last_update LIMIT 3;
/*130,333,408*/

/*¿Cuál es la tarifa de alquiler promedio de las películas? ¿Puedes redondear el resultado a 2 decimales?*/
SELECT TRUNC(AVG(rental_rate),2) as promedio_alquiler FROM film;

/*Cuenta el número de ciudades para cada country_id en la tabla city. Ordena los resultados por count(*).*/
WITH CTE AS(
	SELECT country_id,COUNT(city) AS cantidad_ciudades FROM city GROUP BY country_id ORDER BY country_id
) SELECT * FROM CTE ORDER BY cantidad_ciudades,country_id;

/*¿Qué película (id) tiene la mayor cantidad de actores?*/
WITH CTE AS(
	SELECT film_id,COUNT (actor_id) AS actores FROM film_actor GROUP BY film_id ORDER BY film_id
)SELECT * FROM CTE ORDER BY actores DESC LIMIT 1;
/*film_id 508 con 15 actores*/

/*¿Qué actor (id) aparece en la mayor cantidad de películas?*/
WITH CTE AS(
	SELECT actor_id,COUNT (film_id) AS peliculas FROM film_actor GROUP BY actor_id ORDER BY actor_id
)SELECT * FROM CTE ORDER BY peliculas DESC LIMIT 1;
/*actor_id 107 con 42 peliculas*/

/*¿Cuáles son las diferentes duraciones de alquiler permitidas por la tienda?*/
WITH CTE AS(
	SELECT rental_duration,COUNT(DISTINCT rental_duration) FROM film GROUP BY rental_duration
) SELECT rental_duration FROM CTE ORDER BY rental_duration;
/*3,4,5,6,7*/

/*Selecciona los 10 actores que tienen los nombres más largos (nombre y apellido combinados).*/
WITH CTE AS(
	select actor_id,first_name,last_name,char_length(rpad(first_name,(char_length(first_name)+char_length(last_name)),last_name))AS longitud_nombre from actor
) select * from CTE ORDER BY longitud_nombre desc,actor_id limit 10;

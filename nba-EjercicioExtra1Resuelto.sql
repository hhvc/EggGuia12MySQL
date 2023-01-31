/* Abrir el script de la base de datos llamada “nba.sql” y ejecutarlo para crear todas las tablas e
insertar datos en las mismas. A continuación, generar el modelo de entidad relación. Deberá
obtener un diagrama de entidad relación igual al que se muestra a continuación:*/

-- Respuesta: Con Crl+R (ó Database/ Reverse Engineer) generamos el diagrama del modelo de Entidad Relación.

# A continuación, se deben realizar las siguientes consultas sobre la base de datos:

-- 1. Mostrar el nombre de todos los jugadores ordenados alfabéticamente.
SELECT NOMBRE FROM JUGADORES ORDER BY NOMBRE;

-- 2. Mostrar el nombre de los jugadores que sean pivots (‘C’) y que pesen más de 200 libras, ordenados por nombre alfabéticamente.
SELECT nombre FROM JUGADORES WHERE POSICION like '%C%' AND PESO >200 ORDER BY NOMBRE;

-- 3. Mostrar el nombre de todos los equipos ordenados alfabéticamente.
SELECT NOMBRE FROM EQUIPOS ORDER BY NOMBRE;

-- 4. Mostrar el nombre de los equipos del este (East).
SELECT NOMBRE FROM EQUIPOS WHERE CONFERENCIA LIKE '%EAST%';

-- 5. Mostrar los equipos donde su ciudad empieza con la letra ‘c’, ordenados por nombre.
SELECT NOMBRE FROM EQUIPOS WHERE CIUDAD LIKE 'C%' order by nombre;

-- 6. Mostrar todos los jugadores y su equipo ordenados por nombre del equipo.
SELECT * FROM JUGADORES ORDER BY NOMBRE_EQUIPO;

-- 7. Mostrar todos los jugadores del equipo “Raptors” ordenados por nombre.
SELECT * FROM JUGADORES WHERE NOMBRE_EQUIPO LIKE '%RAPTORS%' order by NOMBRE;

-- 8. Mostrar los puntos por partido del jugador ‘Pau Gasol’.
SELECT PUNTOS_POR_PARTIDO FROM ESTADISTICAS WHERE JUGADOR = (SELECT CODIGO FROM JUGADORES WHERE NOMBRE LIKE '%PAU GASOL%');

-- 9. Mostrar los puntos por partido del jugador ‘Pau Gasol’ en la temporada ’04/05′.
SELECT PUNTOS_POR_PARTIDO FROM ESTADISTICAS WHERE JUGADOR = (SELECT CODIGO FROM JUGADORES WHERE NOMBRE LIKE '%PAU GASOL%') AND TEMPORADA ='04/05';

-- 10. Mostrar el número de puntos de cada jugador en toda su carrera.
select sum(puntos_por_partido) PUNTOS_TOTALES_POR_JUGADOR from estadisticas group by jugador;
-- detallando código y nombre del jugador:
SELECT E.JUGADOR COD_JUGADOR, J.NOMBRE, SUM(E.PUNTOS_POR_PARTIDO) FROM ESTADISTICAS E JOIN JUGADORES J ON E.JUGADOR = J.CODIGO group by JUGADOR ORDER BY E.JUGADOR;

-- 11. Mostrar el número de jugadores de cada equipo.
SELECT NOMBRE_EQUIPO, COUNT(*) FROM JUGADORES GROUP BY NOMBRE_EQUIPO;

-- 12. Mostrar el jugador que más puntos ha realizado en toda su carrera.
SELECT 
    *
FROM
    JUGADORES
WHERE
    CODIGO IN (SELECT 
            JUGADOR
        FROM
            ESTADISTICAS
        GROUP BY JUGADOR
        HAVING SUM(PUNTOS_POR_PARTIDO) = (SELECT 
                SUM(PUNTOS_POR_PARTIDO)
            FROM
                ESTADISTICAS
            GROUP BY JUGADOR
            ORDER BY SUM(PUNTOS_POR_PARTIDO) DESC
            LIMIT 1));
            
-- 13. Mostrar el nombre del equipo, conferencia y división del jugador más alto de la NBA.
SELECT NOMBRE, CONFERENCIA, DIVISION FROM EQUIPOS WHERE NOMBRE = (SELECT NOMBRE_EQUIPO FROM JUGADORES ORDER BY ALTURA DESC LIMIT 1);
-- otra forma:
SELECT NOMBRE, CONFERENCIA, DIVISION FROM EQUIPOS WHERE NOMBRE = (SELECT NOMBRE_EQUIPO FROM JUGADORES WHERE ALTURA = (SELECT MAX(ALTURA) FROM JUGADORES));

-- 14. Mostrar la media de puntos en partidos de los equipos de la división Pacific.
SELECT 
    J.NOMBRE_EQUIPO, AVG(E.PUNTOS_POR_PARTIDO)
FROM
    JUGADORES J
        JOIN
    ESTADISTICAS E
GROUP BY J.NOMBRE_EQUIPO
HAVING J.NOMBRE_EQUIPO IN (SELECT 
        nombre
    FROM
        equipos
    WHERE
        DIVISION LIKE '%PACIFIC%');

-- 15. Mostrar el partido o partidos (equipo_local, equipo_visitante y diferencia) con mayor diferencia de puntos.
select EQUIPO_LOCAL, EQUIPO_VISITANTE, ABS(puntos_local -puntos_visitante) "DIFERENCIA DE PUNTOS" from partidos where ABS(puntos_local -puntos_visitante) = (select MAX(ABS(puntos_local-puntos_visitante)) from partidos);

-- 16. Mostrar la media de puntos en partidos de los equipos de la división Pacific.
SELECT AVG(PUNTOS_LOCAL + PUNTOS_VISITANTE) AS "Puntos Promedio" FROM PARTIDOS WHERE equipo_local OR EQUIPO_VISITANTE in (select nombre FROM EQUIPOS WHERE DIVISION = 'PACIFIC');

-- 17. Mostrar los puntos de cada equipo en los partidos, tanto de local como de visitante.
SELECT T1.EQUIPO, PUNTOS_LOCAL, PUNTOS_VISITANTE, PUNTOS_LOCAL + PUNTOS_VISITANTE TOTAL_PUNTOS  FROM (SELECT EQUIPO_LOCAL EQUIPO, SUM(PUNTOS_LOCAL) PUNTOS_LOCAL FROM PARTIDOS GROUP BY EQUIPO) T1 JOIN (SELECT EQUIPO_VISITANTE EQUIPO, SUM(PUNTOS_VISITANTE) PUNTOS_VISITANTE FROM PARTIDOS GROUP BY EQUIPO) T2 ON T1.EQUIPO = T2.EQUIPO;

SELECT 
    T1.EQUIPO, PUNTOS_LOCAL, PUNTOS_VISITANTE, (PUNTOS_LOCAL + PUNTOS_VISITANTE) SUMA
FROM
    (SELECT 
        EQUIPO_LOCAL EQUIPO, SUM(PUNTOS_LOCAL) PUNTOS_LOCAL
    FROM
        PARTIDOS
    GROUP BY EQUIPO) T1
        JOIN
    (SELECT 
        EQUIPO_VISITANTE EQUIPO,
            SUM(PUNTOS_VISITANTE) PUNTOS_VISITANTE
    FROM
        PARTIDOS
    GROUP BY EQUIPO) T2 ON T1.EQUIPO = T2.EQUIPO;

-- 18. Mostrar quien gana en cada partido (codigo, equipo_local, equipo_visitante, equipo_ganador), en caso de empate sera null.
SELECT 
    CODIGO,
    EQUIPO_LOCAL,
    EQUIPO_VISITANTE,
    IF(PUNTOS_LOCAL > PUNTOS_VISITANTE,
        EQUIPO_LOCAL,
        IF(PUNTOS_VISITANTE > PUNTOS_LOCAL,
            EQUIPO_VISITANTE,
            NULL)) EQUIPO_GANADOR
FROM
    PARTIDOS;

-- Otra forma con case (En vez de empate, en caso de empate, el ejercicio pide NULL y sin poner el "else" el sistema devuelve null... Dejo empate como ayuda memoria de cómo opera Case/where/then/else/end
    SELECT 
    CODIGO PARTIDO,
    EQUIPO_LOCAL 'LOCAL',
    EQUIPO_VISITANTE 'VISITANTE',
    CASE
        WHEN PUNTOS_LOCAL > PUNTOS_VISITANTE THEN EQUIPO_LOCAL
        WHEN PUNTOS_LOCAL < PUNTOS_VISITANTE THEN EQUIPO_VISITANTE
        else 'EMPATE'
    END GANADOR
FROM
    PARTIDOS;



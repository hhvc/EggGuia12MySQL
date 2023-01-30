# EJERCICIO 2 EGG GUIA 12 MYSGL RESUELTO
/*Abrir el script de la base de datos llamada “tienda.sql” y ejecutarlo para crear sus tablas e
insertar datos en las mismas.*/

-- A continuación, generar el modelo de entidad relación. Deberá obtener un diagrama de entidad relación igual al que se muestra a continuación:

-- Solución: Se obtiene con menú Database/ Reverse Engineer ó las teclas Ctl + R

USE tienda;

# A continuación, se deben realizar las siguientes consultas sobre la base de datos:

-- 1. Lista el nombre de todos los productos que hay en la tabla producto.
SELECT * FROM producto;

-- 2. Lista los nombres y los precios de todos los productos de la tabla producto.
SELECT nombre, precio FROM producto;

-- 3. Lista todas las columnas de la tabla producto.
SHOW COLUMNS FROM producto;

-- 4. Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.
SELECT NOMBRE, ROUND(PRECIO) FROM PRODUCTO;

-- 5. Lista el código de los fabricantes que tienen productos en la tabla producto.
SELECT CODIGO_FABRICANTE FROM PRODUCTO;

-- 6. Lista el código de los fabricantes que tienen productos en la tabla producto, sin mostrar los repetidos.
SELECT CODIGO_FABRICANTE FROM PRODUCTO GROUP BY CODIGO_FABRICANTE;

-- 7. Lista los nombres de los fabricantes ordenados de forma ascendente.
SELECT 
    CODIGO_FABRICANTE
FROM
    PRODUCTO
ORDER BY CODIGO_FABRICANTE;

-- 8. Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo lugar por el precio de forma descendente.
SELECT NOMBRE FROM PRODUCTO ORDER BY NOMBRE ASC, PRECIO DESC;

-- 9. Devuelve una lista con las 5 primeras filas de la tabla fabricante.
SELECT * FROM FABRICANTE LIMIT 5;

-- 10. Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT)
SELECT NOMBRE, PRECIO FROM PRODUCTO ORDER BY PRECIO LIMIT 1;

-- 11. Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)
SELECT NOMBRE, PRECIO FROM PRODUCTO ORDER BY PRECIO DESC LIMIT 1;

-- 12. Lista el nombre de los productos que tienen un precio menor o igual a $120.
SELECT NOMBRE FROM PRODUCTO WHERE PRECIO <= 120;

-- 13. Lista todos los productos que tengan un precio entre $60 y $200. Utilizando el operador BETWEEN.
SELECT * FROM PRODUCTO WHERE PRECIO BETWEEN 60 AND 200;

-- 14. Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Utilizando el operador IN.
SELECT * FROM PRODUCTO WHERE CODIGO_FABRICANTE IN (1, 3, 5);

-- 15. Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre.
SELECT NOMBRE FROM PRODUCTO WHERE NOMBRE LIKE "%Portátil%";


# Consultas Multitabla

-- 1. Devuelve una lista con el código del producto, nombre del producto, código del fabricante y nombre del fabricante, de todos los productos de la base de datos.
SELECT P.CODIGO, P.NOMBRE, P.CODIGO_FABRICANTE, F.NOMBRE FROM PRODUCTO P JOIN FABRICANTE F ON P.CODIGO_FABRICANTE = F.CODIGO;

-- 2. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. Ordene el resultado por el nombre del fabricante, por orden alfabético.
SELECT P.NOMBRE, P.PRECIO, F.NOMBRE FROM PRODUCTO P JOIN FABRICANTE F ON P.CODIGO_FABRICANTE = F.CODIGO ORDER BY F.NOMBRE;

-- 3. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.
SELECT P.NOMBRE, P.PRECIO, F.NOMBRE FROM PRODUCTO P JOIN FABRICANTE F ON P.CODIGO_FABRICANTE = F.CODIGO ORDER BY PRECIO LIMIT 1;
	/* OBSSERVACIÓN: SI QUISIERAMOS LISTAR TODOS LOS PRODUCTOS QUE COINCIDAN CON EL PRECIO MÁS ECONÓMICO, EN CASO DE QUE HAYA MÁS DE UNO CON EL MISMO PRECIO
	PODRÍAMOS HACERLO CON UNA SUBCONSULTA*/
	SELECT P.NOMBRE, P.PRECIO, F.NOMBRE FROM PRODUCTO P JOIN FABRICANTE F ON P.CODIGO_FABRICANTE = F.CODIGO WHERE PRECIO = (SELECT MIN(PRECIO) FROM PRODUCTO); 

-- 4. Devuelve una lista de todos los productos del fabricante Lenovo.
SELECT * FROM PRODUCTO P JOIN FABRICANTE F ON P.CODIGO_FABRICANTE = F.CODIGO WHERE F.NOMBRE LIKE '%LENOVO%';

-- 5. Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que $200.
SELECT * FROM PRODUCTO P JOIN FABRICANTE F ON P.CODIGO_FABRICANTE = F.CODIGO WHERE F.NOMBRE LIKE '%CRUCIAL%' AND P.PRECIO > 200; 

-- 6. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard. Utilizando el operador IN.
SELECT * FROM PRODUCTO P JOIN FABRICANTE F ON P.CODIGO_FABRICANTE = F.CODIGO WHERE F.NOMBRE IN('ASUS', 'HEWLETT-PACKARD');

-- 7. Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a $180. Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)
SELECT P.NOMBRE, P.PRECIO, F.NOMBRE FROM PRODUCTO P JOIN FABRICANTE F ON P.CODIGO_FABRICANTE = F.CODIGO WHERE PRECIO >=180 ORDER BY P.PRECIO DESC, P.NOMBRE ASC;


# Consultas Multitabla
#Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.
-- 1. Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos que tiene cada uno de ellos. El listado deberá mostrar también aquellos fabricantes que no tienen productos asociados.
SELECT * FROM FABRICANTE F LEFT JOIN PRODUCTO P ON F.CODIGO = P.CODIGO_FABRICANTE;

-- 2. Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.
SELECT F.* FROM FABRICANTE F LEFT JOIN PRODUCTO P ON F.CODIGO = P.CODIGO_FABRICANTE GROUP BY F.CODIGO HAVING COUNT(P.CODIGO)=0;

# Subconsultas (En la cláusula WHERE) con operadores básicos de comparación
-- 1. Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).
SELECT * FROM PRODUCTO WHERE CODIGO_FABRICANTE = (SELECT CODIGO FROM FABRICANTE WHERE NOMBRE LIKE '%LENOVO%');

-- 2. Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del fabricante Lenovo. (Sin utilizar INNER JOIN).
SELECT * FROM PRODUCTO WHERE PRECIO = (SELECT MAX(PRECIO) FROM PRODUCTO WHERE CODIGO_FABRICANTE = (SELECT CODIGO FROM FABRICANTE WHERE NOMBRE LIKE "%LENOVO%"));

-- 3. Lista el nombre del producto más caro del fabricante Lenovo.
SELECT NOMBRE FROM PRODUCTO WHERE PRECIO = (SELECT MAX(PRECIO) FROM PRODUCTO WHERE CODIGO_FABRICANTE = (SELECT CODIGO FROM FABRICANTE WHERE NOMBRE LIKE "%LENOVO%"));
SELECT NOMBRE FROM PRODUCTO WHERE CODIGO_FABRICANTE = (SELECT CODIGO FROM FABRICANTE WHERE NOMBRE LIKE "%LENOVO%") ORDER BY PRECIO DESC LIMIT 1;

-- 4. Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos.
SELECT * FROM PRODUCTO WHERE CODIGO_FABRICANTE = (SELECT CODIGO FROM FABRICANTE WHERE NOMBRE LIKE "%ASUS%") AND PRECIO > (SELECT AVG(PRECIO) FROM PRODUCTO);

# Subconsultas con IN y NOT IN
-- 1. Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT IN).
SELECT NOMBRE FROM FABRICANTE WHERE CODIGO IN(SELECT CODIGO_FABRICANTE FROM PRODUCTO GROUP BY CODIGO_FABRICANTE);

-- 2. Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando IN o NOT IN).
SELECT NOMBRE FROM FABRICANTE WHERE CODIGO NOT IN(SELECT CODIGO_FABRICANTE FROM PRODUCTO GROUP BY CODIGO_FABRICANTE);

# Subconsultas (En la cláusula HAVING)
-- 1. Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número de productos que el fabricante Lenovo.
SELECT 
    NOMBRE
FROM
    FABRICANTE
WHERE
    CODIGO IN (SELECT 
            CODIGO_FABRICANTE
        FROM
            PRODUCTO
        GROUP BY CODIGO_FABRICANTE
        HAVING COUNT(*) = (SELECT 
                COUNT(CODIGO)
            FROM
                PRODUCTO
            WHERE
                CODIGO_FABRICANTE = (SELECT 
                        CODIGO
                    FROM
                        FABRICANTE
                    WHERE
                        NOMBRE LIKE '%LENOVO')));

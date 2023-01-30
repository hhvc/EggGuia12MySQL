# ejercicio 1
/* A continuación, realizar las siguientes consultas sobre la base de datos personal: */

use personal;
-- 1) obtener datos de empleados
SELECT * FROM empleados;
-- 2) Obtener los datos completos de los departamentos. 
SELECT * FROM departamentos;
-- 3) Listar el nombre de los departamentos.
SELECT nombre_depto FROM departamentos;
-- 4) Obtener el nombre y salario de todos los empleados
SELECT nombre, sal_emp Salario FROM empleados;
-- 5) Listar todas las comisiones
SELECT comision_emp Comisión FROM empleados;
-- 6) Obtener los datos de los empleados cuyo cargo sea secretaria
SELECT * FROM empleados WHERE cargo_emp = 'SECRETARIA';
-- 7) Obtener los datos de los vendedores ordenados alfabéticamente
SELECT * FROM empleados WHERE cargo_emp = "vendedor" order by nombre asc;
-- 8) Obtener el nombre y cargo de todos los empleados ordenados por salario de mayora a menor
SELECT nombre, cargo_emp, sal_emp FROM empleados order by sal_emp desc;
-- 9) Obtener el nombre de los jefes que tengan su departamento cituado en Ciudad Real
SELECT nombre_jefe_depto FROM departamentos WHERE ciudad LIKE '%ciu__d%real%';
-- 10) Elabore un listado donde para cada fila figure el alias Nombre y Cargo para las respectivas tablas de empleados
SELECT nombre AS Nombre, cargo_emp       Cargo FROM empleados;
-- 11) Listar los salarios y comisiones de los empleados del departamento 2000 ordenados por comisión de menor a mayor
SELECT sal_emp AS Salario, comision_emp AS Comisión FROM empleados WHERE id_depto = 2000 order by comision_emp ASC;
-- 12) Obtener el valor total a pagar a los empleados del departamento 3000 que resulta de sumar el salario y la comisión más una bonificación de 500, mostrar el nombre del empleado y el total a pagar en orden alfabético.
SELECT nombre, sal_emp AS Salario, comision_emp AS Comisión, sal_emp + comision_emp + 500 AS Remuneración_Total FROM empleados WHERE id_depto = 3000 ORDER BY nombre ASC;
-- 13) Muestra los empeados cuyo nombre empieza con letra J
SELECT nombre FROM empleados WHERE nombre LIKE 'j%';
-- 14) LIstar el salario, la comisión, el salario total (salario + comisión) y nombre de aquellos empleados que tienen comisión mayor a 1.000
SELECT sal_emp, comision_emp, sal_emp+comision_emp Salario_Total, nombre FROM empleados WHERE comision_emp > 1000;
-- 15) Obtener un listado similar al anterior pero de los empleados que no tienen comisión:
SELECT sal_emp, comision_emp, sal_emp+comision_emp as Salario_Total, nombre FROM empleados WHERE comision_emp IN (NULL, 0);
-- 16) Obtener la lista de los empleados que ganan una comisión superior a su sueldo
SELECT * FROM empleados WHERE comision_emp > sal_emp;
-- 17) Listar los empleados cuya comisión es menor o igual al 30% de su sueldo
SELECT * FROM empleados WHERE comision_emp <= sal_emp*0.3;
-- 18) Hallar los empleados cuyo nombre no contiene la cadena "ma"
SELECT * FROM empleados WHERE nombre NOT LIKE '%ma%';
-- 19) Obtener los nombre de los departamentos que sean Ventas, Investigación o Mantenimiento
SELECT nombre_depto FROM departamentos WHERE nombre_depto LIKE 'venta%' OR nombre_depto LIKE '%investiga%' OR nombre_depto LIKE '%manten%';
-- 20) Ahora obtener el contrario al punto anterior (dtos que no sean venta....)
SELECT nombre_depto FROM departamentos WHERE nombre_depto NOT LIKE '%venta%' AND nombre_depto NOT LIKE '%investiga%' AND nombre_depto NOT LIKE '%manten%';
-- 21) Mostrar el salario más alto de la empresa
SELECT sal_emp FROM empleados ORDER BY sal_emp DESC LIMIT 1;
-- OTRA ALTERNATIVA MÁS EFICIENTE:
SELECT MAX(sal_emp) FROM empleados;
-- 22) Mostrar el nombre del último empleado de la lísta por orden alfabético
SELECT nombre FROM empleados ORDER BY nombre desc LIMIT 1;
-- OTRA ALTERNATIVA MÁS EFICIENTE:
SELECT MAX(nombre) FROM empleados;
-- 23) Hallar el salario más alto, el más bajo y la diferencia entre ellos.
select MAX(sal_emp) AS Mayor_Salario, MIN(sal_emp) Menor_Salario, MAX(sal_emp) - MIN(sal_emp) AS Diferencia FROM empleados;
-- 24) Hallar el salario promedio por departamento
SELECT id_depto, AVG(sal_emp), COUNT(*) AS Empleados FROM empleados GROUP BY id_depto;
-- 25) "CONSULTAS CON HAVING": Hallar los dtos que tienen más de 3 empleados y mostrar el número de empleados de esos dptos.
SELECT id_depto, COUNT(*) AS Cantidad_De_Empleados FROM empleados GROUP BY id_depto HAVING Cantidad_De_Empleados > 3;
-- 26) Hallar los departamentos que no tienen empleados
SELECT 
    departamentos.id_depto, departamentos.nombre_depto
FROM
    departamentos
        LEFT JOIN
    empleados ON departamentos.id_depto = empleados.id_depto
GROUP BY DEPARTAMENTOS.ID_DEPTO
HAVING COUNT(empleados.id_emp) = 0;

-- 27) "CONSULTA MULTI TABLE, USO DE CONSULTA LEFT JOIN, RIGHT JOIN e INNER JOIN)
-- Mostrar la lista de empleados con su respectivo departamento y el jefe de ese departamento
SELECT nombre, nombre_depto, nombre_jefe_depto FROM empleados LEFT JOIN departamentos on empleados.id_depto = departamentos.id_depto;
-- 28) Mostrar la lista de los empleados cuyo salario es mayor o igual al promedio de la empresa y ordenarlo por departamento
SELECT * FROM empleados WHERE sal_emp >= (SELECT AVG(sal_emp) FROM empleados) ORDER BY id_depto;
-- Ahora usando el join para traer el nombre del departamento
SELECT 
    nombre,
    sal_emp,
    comision_emp,
    cargo_emp,
    nombre_depto,
    nombre_jefe_depto
FROM
    empleados emp
        LEFT JOIN
    departamentos dto ON emp.id_depto = dto.id_depto
WHERE
    sal_emp >= (SELECT 
            AVG(sal_emp)
        FROM
            empleados)
ORDER BY emp.id_depto;  

select * from jugadores where Procedencia = 'argentina';
select puntos_por_partido from estadistica
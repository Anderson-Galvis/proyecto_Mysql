
-- Listar todos los parques naturales
SELECT * FROM parques;

-- Listar todos los departamentos y sus parques asociados.
SELECT d.nombre_departamento, p.nombre_parque
FROM departamentos d
JOIN departamento_parque dp ON d.id = dp.departamento_id
JOIN parques p ON dp.parque_id = p.id;

-- Obtener el número total de parques registrados
SELECT COUNT(*) AS total_parques FROM parques;

--Buscar un parque por su nombre.
SELECT * FROM parques WHERE nombre_parque LIKE '%Amazonas%';

-- Obtener el área total de todos los parques
SELECT SUM(extension_area) AS superficie_total FROM area;

-- Listar todas las especies registradas.
SELECT * FROM especies;

--Contar cuántas especies hay en cada parque
SELECT p.nombre_parque, COUNT(ae.especies_id) AS total_especies
FROM parques p
JOIN areas_parques ap ON p.id = ap.parque_id
JOIN area_especies ae ON ap.area_id = ae.area_id
GROUP BY p.nombre_parque;

-- Buscar una especie por su nombre científico
SELECT * FROM especies WHERE nombre_cientifico LIKE '%Panthera onca%';

--Listar todas las especies y su tipo.
SELECT DISTINCT tipo FROM especies;

-- Contar cuántas especies están en peligro de extinción
SELECT COUNT(*) AS especies_peligro
FROM especies
WHERE tipo = 'En peligro';


-- Listar todos los empleados.
SELECT * FROM empleados;


-- Obtener el total de empleados en cada parque
SELECT p.nombre_parque, COUNT(e.id) AS total_empleados
FROM empleados e
JOIN puesto_vigilancia pv ON e.id = pv.empleado_id
JOIN areas_parques ap ON pv.empleado_id = ap.area_id
JOIN parques p ON ap.parque_id = p.id
GROUP BY p.nombre_parque;

-- Listar los empleados con mayor sueldo
SELECT * FROM empleados ORDER BY sueldo DESC LIMIT 10;

-- Obtener la cantidad de empleados por puesto
SELECT puesto_trabajo, COUNT(*) AS total_empleados FROM empleados GROUP BY puesto_trabajo;

-- Buscar un empleado por su número de cédula.
SELECT * FROM empleados WHERE cedula_empleado = 123456789;

-- Listar todos los proyectos de conservación 
SELECT * FROM proyectos;

-- Obtener el presupuesto total de proyectos en ejecución
SELECT SUM(presupuesto_proyecto) AS presupuesto_total FROM proyectos WHERE fecha_fin > NOW();

-- Contar cuántos proyectos están activos actualmente
SELECT COUNT(*) AS proyectos_activos FROM proyectos WHERE fecha_fin > NOW();


-- Listar los investigadores involucrados en cada proyecto.
SELECT p.nombre_proyecto, e.nombre_empleado
FROM proyectos p
JOIN proyecto_investigador pi ON p.id = pi.proyecto_id
JOIN empleados e ON pi.investigador_id = e.id;

-- Listar los proyectos y las especies investigadas.
SELECT p.nombre_proyecto, es.nombre_especie
FROM proyectos p
JOIN proyecto_especie_investigador pei ON p.id = pei.proyecto_id
JOIN especies es ON pei.especies_id = es.id;

-- Obtener el total de visitantes en un parque en el último mes.
SELECT COUNT(*) AS total_visitantes
FROM estadia_usuario eu
JOIN hostal_parque hp ON eu.hostal_id = hp.id
WHERE hp.parque_id = 1 AND fecha_ingreso >= DATE_SUB(NOW(), INTERVAL 1 MONTH);

-- Listar los hostales y su capacidad.
SELECT nombre_hostal, capacidad FROM hostal_parque;

-- Obtener el promedio de estadía de visitantes.
SELECT AVG(DATEDIFF(fecha_salida, fecha_ingreso)) AS promedio_estadia FROM estadia_usuario;

-- Listar los visitantes con más registros de estadías
SELECT u.nombre_user, COUNT(*) AS total_estadias
FROM estadia_usuario eu
JOIN usuarios u ON eu.usuario_id = u.id
GROUP BY u.nombre_user
ORDER BY total_estadias DESC
LIMIT 10;

-- Obtener los parques con más visitantes en el último año
SELECT p.nombre_parque, COUNT(*) AS total_visitantes
FROM estadia_usuario eu
JOIN hostal_parque hp ON eu.hostal_id = hp.id
JOIN parques p ON hp.parque_id = p.id
WHERE fecha_ingreso >= DATE_SUB(NOW(), INTERVAL 1 YEAR)
GROUP BY p.nombre_parque
ORDER BY total_visitantes DESC;


-- 1 superficie total de parques por departamento 

DELIMITER //
CREATE FUNCTION superficie_total_parques(depto_id INT) RETURNS FLOAT
DETERMINISTIC
BEGIN
    DECLARE total FLOAT;
    SELECT SUM(a.extension_area) INTO total
    FROM area a
    JOIN areas_parques ap ON a.id = ap.area_id
    JOIN departamento_parque dp ON ap.parque_id = dp.parque_id
    WHERE dp.departamento_id = depto_id;
    RETURN COALESCE(total, 0);
END //
DELIMITER ;

-- inventario de especies por area y tipo 
DELIMITER //
CREATE FUNCTION total_especies_por_area(area_id INT, tipo_especie VARCHAR(20)) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM area_especies ae
    JOIN especies e ON ae.especies_id = e.id
    WHERE ae.area_id = area_id AND e.tipo = tipo_especie;
    RETURN COALESCE(total, 0);
END //
DELIMITER ;

--3 calculo de costos operativos del proyecto 
DELIMITER //
CREATE FUNCTION costo_total_proyecto(proyecto_id INT) RETURNS DECIMAL(20,2)
DETERMINISTIC
BEGIN
    DECLARE costo DECIMAL(20,2);
    SELECT presupuesto_proyecto INTO costo FROM proyectos WHERE id = proyecto_id;
    RETURN COALESCE(costo, 0);
END //
DELIMITER ;

--4 cantidad de empleados en un parque
DELIMITER //
CREATE FUNCTION total_empleados_parque(parque_id INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM empleados e
    JOIN areas_parques ap ON e.id = ap.area_id
    WHERE ap.parque_id = parque_id;
    RETURN COALESCE(total, 0);
END //
DELIMITER ;

-- 5 total de vigilantes en un parque 
DELIMITER //
CREATE FUNCTION total_vigilantes_parque(parque_id INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM puesto_vigilancia pv
    JOIN empleados e ON pv.empleado_id = e.id
    JOIN area_vigilante av ON pv.empleado_id = av.guarda_id
    JOIN areas_parques ap ON av.area_id = ap.area_id
    WHERE ap.parque_id = parque_id;
    RETURN COALESCE(total, 0);
END //
DELIMITER ;
 
 -- 6 cantidad de hostales en un parque 
 DELIMITER //
CREATE FUNCTION total_hostales_parque(parque_id INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM hostal_parque WHERE parque_id = parque_id;
    RETURN COALESCE(total, 0);
END //
DELIMITER ;

-- 7 capacidad total de hostales en un parque
DELIMITER //
CREATE FUNCTION capacidad_total_hostales(parque_id INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE capacidad_total INT;
    SELECT SUM(capacidad) INTO capacidad_total FROM hostal_parque WHERE parque_id = parque_id;
    RETURN COALESCE(capacidad_total, 0);
END //
DELIMITER ;

-- 8 total de especies en un parque 
DELIMITER //
CREATE FUNCTION total_especies_parque(parque_id INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(DISTINCT ae.especies_id) INTO total
    FROM area_especies ae
    JOIN areas_parques ap ON ae.area_id = ap.area_id
    WHERE ap.parque_id = parque_id;
    RETURN COALESCE(total, 0);
END //
DELIMITER ;

-- 9 cantidad total de empleados 
DELIMITER //
CREATE FUNCTION total_empleados() RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM empleados;
    RETURN COALESCE(total, 0);
END //
DELIMITER ;

-- 10 costo promedio de los proyectos 
DELIMITER //
CREATE FUNCTION promedio_costos_proyectos() RETURNS DECIMAL(20,2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(20,2);
    SELECT AVG(presupuesto_proyecto) INTO promedio FROM proyectos;
    RETURN COALESCE(promedio, 0);
END //
DELIMITER ;

-- 11 numero total de parques registrados
DELIMITER //
CREATE FUNCTION total_parques() RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM parques;
    RETURN COALESCE(total, 0);
END //
DELIMITER ;

-- 12 numero de departamentos con parques 
DELIMITER //
CREATE FUNCTION total_departamentos_con_parques() RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(DISTINCT departamento_id) INTO total FROM departamento_parque;
    RETURN COALESCE(total, 0);
END //
DELIMITER ;

-- 13 duracion poromedio de proyectos
DELIMITER //
CREATE FUNCTION promedio_duracion_proyectos() RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE promedio INT;
    SELECT AVG(DATEDIFF(fecha_fin, fecha_inicio)) INTO promedio FROM proyectos;
    RETURN COALESCE(promedio, 0);
END //
DELIMITER ;

-- 14 total deespecies en peligro extincion
DELIMITER //
CREATE FUNCTION total_especies_peligro() RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM especies WHERE tipo = 'en peligro';
    RETURN COALESCE(total, 0);
END //
DELIMITER ;

-- 15 total de areas registradas 
DELIMITER //
CREATE FUNCTION total_areas() RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM area;
    RETURN COALESCE(total, 0);
END //
DELIMITER ;

--16 salario promedio de empleados 
DELIMITER //
CREATE FUNCTION salario_promedio_empleados() RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE promedio DECIMAL(10,2);
    SELECT AVG(sueldo) INTO promedio FROM empleados;
    RETURN COALESCE(promedio, 0);
END //
DELIMITER ;

-- total de visitantes en un parque 
DELIMITER //
CREATE FUNCTION total_visitantes_parque(parque_id INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM estadia_usuario eu
    JOIN hostal_parque hp ON eu.hostal_id = hp.id
    WHERE hp.parque_id = parque_id;
    RETURN COALESCE(total, 0);
END //
DELIMITER ;

-- 18 cantidad de especie estudiadas en un proyecto 
DELIMITER //
CREATE FUNCTION especies_en_proyecto(proyecto_id INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM proyecto_especie_investigador WHERE proyecto_id = proyecto_id;
    RETURN COALESCE(total, 0);
END //
DELIMITER ;

-- vehiculos en el parque DELIMITER //
CREATE FUNCTION total_vehiculos() RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total FROM vehiculo;
    RETURN COALESCE(total, 0);
END //
DELIMITER ;

--20 cantidad de parques con acceso a un rio 
DELIMITER //
CREATE FUNCTION total_parques_con_rio() RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(DISTINCT ap.parque_id) INTO total
    FROM areas_parques ap
    JOIN area a ON ap.area_id = a.id
    WHERE a.tipo_area LIKE '%río%';
    RETURN COALESCE(total, 0);
END //
DELIMITER ;

# proyecto_Mysql
proyecto modulo mysql creacion de base datos para parque 

Base de Datos para la Gestión de Parques Naturales y Biodiversidad

 Descripción General

Esta base de datos ha sido diseñada para gestionar la información sobre parques naturales, especies registradas, visitantes, alojamientos y proyectos de conservación. Permite realizar análisis sobre la biodiversidad, costos operativos y tendencias de visitas, optimizando la gestión de los recursos naturales.

 Estructura de la Base de Datos

La base de datos se compone de las siguientes tablas clave:

1 Parques

id_parque (INT, PK, AUTO_INCREMENT) → Identificador único del parque.

nombre (VARCHAR) → Nombre del parque.

departamento (VARCHAR) → Ubicación del parque.

superficie (FLOAT) → Área total en hectáreas.

tipo (VARCHAR) → Tipo de parque (Nacional, Reserva, etc.).

2 Especies

id_especie (INT, PK, AUTO_INCREMENT) → Identificador único de la especie.

nombre_cientifico (VARCHAR) → Nombre científico.

nombre_comun (VARCHAR) → Nombre común.

tipo (VARCHAR) → Clasificación (Ave, Mamífero, etc.).

poblacion_estimada (INT) → Número estimado en el parque.

id_parque (INT, FK) → Relación con Parques.

3 Visitantes

id_visitante (INT, PK, AUTO_INCREMENT) → Identificador único del visitante.

nombre (VARCHAR) → Nombre del visitante.

fecha_visita (DATE) → Fecha de la visita.

id_parque (INT, FK) → Relación con Parques.

4 Alojamientos

id_alojamiento (INT, PK, AUTO_INCREMENT) → Identificador único del alojamiento.

tipo (VARCHAR) → Cabaña, camping, hotel, etc.

capacidad (INT) → Número máximo de personas.

id_parque (INT, FK) → Relación con Parques.

5 Proyectos

id_proyecto (INT, PK, AUTO_INCREMENT) → Identificador único del proyecto.

nombre (VARCHAR) → Nombre del proyecto.

descripcion (TEXT) → Objetivo del proyecto.

costo_estimado (DECIMAL) → Costo del proyecto.

id_parque (INT, FK) → Relación con Parques.

Funcionalidades Clave

 Consultas y Cálculos Específicos

 Superficie total de parques por departamento.✔ Inventarios de especies por área y tipo.✔ Cálculo de costos operativos de proyectos.✔ Reportes semanales de visitantes y alojamientos.✔ Actualización periódica de inventarios de especies.

 Eventos Automáticos (Scheduler)

Los siguientes eventos han sido programados para facilitar la gestión automática de datos:

Generar reportes semanales de visitantes.

Actualizar inventarios de especies cada mes.

Eliminar registros de visitantes inactivos después de 1 año.

Calcular ocupación de alojamientos diariamente.

Generar informe de costos de proyectos trimestralmente.

Instrucciones de Uso

 Configuración Inicial

Importar la Base de Datos

mysql -u usuario -p contraseña < base_datos.sql

Habilitar el Event Scheduler (si se usan eventos automáticos)

SET GLOBAL event_scheduler = ON;

Ejecutar Consultas de Reportes (Ejemplo)

SELECT departamento, SUM(superficie) AS superficie_total
FROM Parques
GROUP BY departamento;

 Tecnologías Utilizadas

MySQL → Motor de base de datos.


.
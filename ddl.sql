			
-- crear la base de datos asegurando que no este creada una anterior mente.								
Dorp DATA BASE IF EXISTS parques_naturales;									
CREATE DATABASE parques_naturales;					
					
-- cambiamos para usar la base de datos					

USE parques_naturales;					
					
-- empezamos a crear las tablas con las que empezaremos a trabajar en la base de datos	

-- tabla para los parques.				
CREATE TABLE parques(					
id int not null auto_increment,					
nombre_parque varchar(100) not null unique      check(TRIM(nombre_parque)!=''),					
fecha_declaracion DATE NOT NULL					
);					
					
					
-- tabla departamentos.					
CREATE TABLE departamentos(					
id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,					
nombre_departamento varchar(50) NOT NULL UNIQUE CHECK (TRIM(name_departamento)!='')					
);					
					
					
-- tabla de union entre departamento y parque.						
CREATE TABLE departamento_parque(					
departamento_id INT UNSIGNED NOT NULL,					
parque_id INT UNSIGNED NOT NUL,					
PRIMARY KEY (departamento_id, parque_id),					
FOREIGN KEY (parque_id) REFERENCES departamentos(id),					
FOREING KEY (parque_id) REFERENCES parques(id)					
);					


-- crear la tabla de area.				
CREATE TABLE area(					
id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,					
nombre_area VARCHAR(50) NOT NULL CHECK (TRIM(nombre_area)!=''),					
extension_area FLOAT NOT NULL CHECK (extension__area > 0)					
);					
					
					
-- tabla para las especies de animales.				
CREATE TABLE especies(					
id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,					
type ENUM('vegetal','animal', 'minerales') NOT NULL ,					
nombre_especie VARCHAR (50) UNIQUE NOT NULL CHECK (TRIM(nombre_especie) !=''),					
nombre_cientifico VARCHAR(200) UNIQUE NOT NULL CHECK(TRIM(nombre_sientifico)!='')					
);					
					
					
-- tabla de union de areas y especies.					
CREATE TABLE area_especies (					
area_id INT UNSIGNED NOT NULL,					
especies_id INT UNSIGNED NOT NULL,					
poblacion_especie INT UNSIGNED NOT NULL,					
FOREING KEY (area_id) REFERENCES area(id) ON DELETE CASCADE					
FOREING KEY (especies_id) REFERENCES especies(id) ON DELETE  CASCADE					
);					
					
					
					
-- tabla para el parque y sus areas.								
CREATE TABLE areas_parques(					
parque_id INT UNSIGNED NOT NULL,					
area_id UNSIGNED NOT NULL,					
PRIMARY KEY (parque_id, area_id),					
FOREING KEY (parque_id) REFERENCES parque(id) ON DELETE CASCADE,					
FOREING KEY (area_id) REFERENCES area(id) ON DELETE CASCADE					
);					
					
					
-- tabla para los empleados de los parques.				
CREATE TABLE empleados(					
id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,					
cedula_empleado INT NOT NULL UNIQUE CHECK (cedula_empleado >),					
nombre_empleado VARCHAR(150) NOT NULL					
CHECK(TRIM(name_empleado)!=''),					
direccion_empleado VARCHAR(200) NOT NULL CHECK(TRIM(direccion_empleado)!=''),					
num_fijo INT UNSIGNED NOT NULL CHECK(num_fijo >= 1000000),					
num_celular INT UNSIGNED NOT NULL CHECK(num_celular >= 1000000000),					
sueldo DECIMA(10,2) NOT NULL CHECK(sueldo > 0),					
puesto_trabajo ENUM('gestion', 'vigilancia', 'conservacion', 'investigador')NOT NULL					
);					
					
					
-- tabla de los cargos de trabajo.				
CREATE TABLE puesto_vigilancia (					
empleado_id INT UNSIGNED PRIMARY KEY NOT NULL,					
FOREING KEY(empleado_id) REFENCES empleados(id) ON DELETE CASCADE					
);					
					
					
-- tabla para el cargo de gestion de los parque.				
CREATE TABLE puesto_gestion(					
empleado_id INT UNSIGNED PRIMARY KEY NOT NULL,					
FOREING KEY(empleado_id) REFERENCES empleado(id) ON DELETE CASCADE					
);					
					
					
-- tabla para el cargo de conservacion de las instalaciones.				
CREATE TABLE puesto_conservacion_parque(					
empleado_id INT UNSIGNED PRIMARY KEY NOT NULL,					
area_espesifica ENUM('limpieza', 'mantenimiento_caminos') NOT NULL					
FOREING KEY (empleado_id) REFERENCES empleados(id) ON DELETE CASCADE					
);					
					
					
-- tabla para el cargo de puesto de investigador					
CREATE TABLE puesto_investigador(					
empleado_id INT UNSIGNED PRIMARY KEY NOT NULL,					
FOREIGN KEY(empleado_id) REFERENCES empleados(id) ON DELETE CASCADE					
);					


-- tabla para organizacion de proyectos.								
CREATE TABLE proyectos(					
id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,					
nombre_proyecto VARCHAR(100) NOT NULL UNIQUE CHECK(TRIM(nombre_proyecto) != ''),					
presupuesto_proyecyto DECIMAL(20,2) NOT NULL CHECK(presupuesto_proyecto > 0),					
fecha_inicio DATE NOT NULL,					
fecha_fin DATE NOT NULL,					
CHECK(fecha_fin > fecha_inicio)					
);					
					
					
-- tabla para unir el proyecto con el investigador.				
CREATE TABLE proyecto_investigador (					
proyecto_id INT UNSIGNED NOT NULL,					
investigador_id INT UNSIGNED NOT NULL,					
PRIMARY KEY(proyecto_id, investigador_id),					
FOREIGN KEY(proyecto_id) REFERENCES proyectos(id) ON DELETE CASCADE,					
FOREIGN KEY(investigador_id) REFERENCES puesto_investigador(empleado_id) ON DELETE CASCADE					
);					
					
-- tabla para unir el investigador, la especie con el proyecto.				
CREATE TABLE proyecto_especie_investigador (					
proyecto_id INT UNSIGNED NOT NULL,					
investigador_id INT UNSIGNED NOT NULL,					
especies_id INT UNSIGNED NOT NULL,					
PRIMARY KEY(proyecto_id, investigador_id, especies_id),					
FOREIGN KEY(proyecto_id) REFERENCES proyectos(id) ON DELETE CASCADE,					
FOREIGN KEY(investigador_id) REFERENCES puesto_investigador(empleado_id) ON DELETE CASCADE,					
FOREIGN KEY(especies_id) REFERENCES especies(id) ON DELETE CASCADE					
);					
					
-- tabla para mangar entradas a el parque.	
CREATE TABLE entrada(					
id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,					
parque_id INT UNSIGNED NOT NULL,					
numero_entrada INT UNSIGNED NOT NULL,					
FOREIGN KEY(parque_id) REFERENCES parques(id) ON DELETE CASCADE					
);					

-- tabla para unir a los guardias con el area que les corresponde.			
CREATE TABLE area_vigilante(
    guara_id INT UNSIGNED NOT NULL,
    area_id INT UNSIGNED NOT NULL,
    vehiculo_id INT UNSIGNED NOT NULL,
    PRIMARY KEY(guarda_id, area_id),
    FOREIGN KEY(guarda_id) REFERENCES puesto_vigilante(empleado_id) ON DELETE CASCADE,
    FOREIGN KEY(area_id) REFERENCES area(id) ON DELETE CASCADE,
    FOREIGN KEY(vehiculo_id) REFERENCES vehiculo(id) ON DELETE CASCADE
);

-- se crea la tabla para los vehiculos vicitantes del parque.			
CREATE TABLE  vehiculo(					
id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,					
tipo_vehiculo VARCHAR(50) NOT NULL CHECK(TRIM(tipo_vehiculo) != ''),					
marca_vehiculo VARCHAR(20) NOT NULL CHECK(TRIM(marca_vehiculo) != '')					
);					
					

-- tabla para unir personal de conservacion(Aseo) con el area de trabajo.
	CREATE TABLE area_conservacion_puesto(
    operario_id INT UNSIGNED NOT NULL,
    area_id INT UNSIGNED NOT NULL,
    PRIMARY KEY(operario_id, area_id),
    FOREIGN KEY(operario_id) REFERENCES puesto_conservacion_parque(empleado_id) ON DELETE CASCADE,
    FOREIGN KEY(area_id) REFERENCES area(id) ON DELETE CASCADE
);		


-- tabla para el cliente que viene a el parque.
CREATE TABLE usuarios(
    id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    cedula_user BIGINT NOT NULL UNIQUE CHECK(cedula > 0),
    nombre_user VARCHAR(80) NOT NULL CHECK(TRIM(name) != ''),
    direccion_user VARCHAR(150) NOT NULL CHECK(TRIM(address) != ''),
    profesion_user VARCHAR(60) NOT NULL CHECK(TRIM(job) != '')
);

-- tabla para el hostal de los usuarios de los parques. 
CREATE TABLE hostal_parque(
    id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    parque_id INT UNSIGNED NOT NULL,
    nombre_hostal VARCHAR(50) NOT NULL CHECK(TRIM(nombre_hostal) != ''),
    capacidad INT NOT NULL CHECK(capacidad > 0),
    categoria VARCHAR(30) NOT NULL CHECK(TRIM(categoria) != ''),
    FOREIGN KEY(parque_id) REFERENCES parques(id) ON DELETE CASCADE
);


-- tabla para estadia de el usuario.
CREATE TABLE estadia_usuario(
    id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT UNSIGNED NOT NULL,
    hostal_id INT UNSIGNED NOT NULL,
    fecha_ingreso DATETIME NOT NULL,
    fecha_salida DATETIME NOT NULL,
    CHECK(fecha_salida > fecha_ingreso),
    FOREIGN KEY(usuario_id) REFERENCES usuario(id) ON DELETE CASCADE,
    FOREIGN KEY(hostal_id) REFERENCES hostal_parque(id) ON DELETE CASCADE 
);

--tabla de la entrada 
CREATE TABLE turno_entrada(
    id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    empleado_id INT UNSIGNED NOT NULL,
    entrada_id INT UNSIGNED NOT NULL,
    fecha_entrada DATETIME NOT NULL,
    fecha_salida DATETIME NOT NULL,
    CHECK (fecha_salida > fecha_entrada),
    FOREIGN KEY(empleado_id) REFERENCES empleado(id),
    FOREIGN KEY(entrada_id) REFERENCES entrada(id)
);


-- tabla para el usuario y el hostal.
CREATE TABLE usuario_hostal(
    id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    estadia_hostal_id INT UNSIGNED NOT NULL,
    visita DATETIME NOT NULL,
    usuario_id INT UNSIGNED NOT NULL,
    FOREIGN KEY(estadia_hostal_id) REFERENCES turno_entrada(id) ON DELETE CASCADE,
    FOREIGN KEY(usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
);


-- tabla de el responsable de el parque 
CREATE TABLE entidad_responsable (
    id INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    nombre_responsable VARCHAR(100) NOT NULL CHECK(TRIM(name) != '')
);


-- tabla para crear relacion entre departamento y la entidad 
CREATE TABLE entidad_departamento(
    departamento_id INT UNSIGNED NOT NULL,
    entidad_id INT UNSIGNED NOT NULL,
    PRIMARY KEY(departamento_id, entidad_id),
    FOREIGN KEY(departamento_id) REFERENCES departamentos(id) ON DELETE CASCADE,
    FOREIGN KEY(entidad_id) REFERENCES entidad_responsable(id) ON DELETE CASCADE
);


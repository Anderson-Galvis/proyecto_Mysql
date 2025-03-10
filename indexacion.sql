CREATE INDEX idx_departamento_id ON departamento_parque(departamento_id);
CREATE INDEX idx_parque_id ON departamento_parque(parque_id);


CREATE INDEX idx_nombre_especie ON especies(nombre_especie);
CREATE INDEX idx_nombre_cientifico ON especies(nombre_cientifico);

CREATE INDEX idx_cedula_empleado ON empleados(cedula_empleado);

CREATE INDEX idx_usuario_estadia ON estadia_usuario(usuario_id);
CREATE INDEX idx_hostal_estadia ON estadia_usuario(hostal_id);

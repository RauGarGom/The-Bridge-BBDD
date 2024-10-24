
CREATE TABLE campus (
   id_campus serial PRIMARY KEY,
   ubicacion varchar (100) NOT NULL
);

CREATE TABLE promociones (
    id_promocion serial PRIMARY KEY,
    promocion varchar (50) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_final DATE NOT NULL,
    temporalidad varchar (50) NOT NULL,
    id_campus int
);

CREATE TABLE profesores (
    id_profesor serial PRIMARY KEY,
    nombre_profesor varchar (50) NOT NULL,
    apellido_profesor varchar (50) NOT NULL,
    edad int NOT NULL,
    pronombre varchar (20) NOT NULL,
    email varchar (50) NOT NULL UNIQUE,
    --id_curso int,
    id_campus int
);

CREATE TABLE cursos (
    id_curso serial PRIMARY KEY,
    bootcamp varchar (50) NOT NULL,
    aula varchar (50) NOT NULL,
    presencialidad varchar (50) NOT NULL,
    id_profesor int,
    id_promocion int
);

CREATE TABLE estudiantes (
    id_estudiante serial PRIMARY KEY,
    nombre_estudiante varchar (50) NOT NULL,
    apellido_estudiante varchar (50) NOT NULL,
    edad int NOT NULL,
    pronombre varchar (20) NOT NULL,
    email varchar (50) NOT NULL UNIQUE,
    id_curso int 
);

CREATE TABLE proyectos (
    id_proyecto serial PRIMARY KEY,
    proyecto varchar (50) NOT NULL,
    id_curso int NOT NULL
);

CREATE TABLE calificaciones (
    id_calificacion serial PRIMARY KEY,
    calificacion varchar (50) NOT NULL,
    id_estudiante int,
    id_proyecto int,
    CONSTRAINT unique_proyecto_estudiante
    UNIQUE (id_proyecto, id_estudiante) 
);



ALTER TABLE profesores
ADD FOREIGN KEY (id_campus) REFERENCES campus(id_campus);

ALTER TABLE promociones
ADD FOREIGN KEY (id_campus) REFERENCES campus(id_campus);

ALTER TABLE cursos
ADD FOREIGN KEY (id_profesor) REFERENCES profesores(id_profesor),
ADD FOREIGN KEY (id_promocion) REFERENCES promociones(id_promocion);

ALTER TABLE proyectos
ADD FOREIGN KEY (id_curso) REFERENCES cursos(id_curso);

ALTER TABLE estudiantes
ADD FOREIGN KEY (id_curso) REFERENCES cursos(id_curso);

ALTER TABLE calificaciones
ADD FOREIGN KEY (id_proyecto) REFERENCES proyectos(id_proyecto),
ADD FOREIGN KEY (id_estudiante) REFERENCES estudiantes(id_estudiante);



INSERT INTO campus (ubicacion)
VALUES 
('Madrid'),
('Valencia'),
('Barcelona');

INSERT INTO promociones (promocion, fecha_inicio, fecha_final,temporalidad, id_campus)
VALUES 
('Septiembre 23', '2023-09-01', '2024-12-30','Full Time', (SELECT id_campus FROM campus WHERE ubicacion='Madrid')),
('Febrero 24', '2024-02-01', '2024-08-30', 'Part Time', (SELECT id_campus FROM campus WHERE ubicacion='Valencia')),
('Septiembre 24', '2024-09-23', '2024-12-13','Full Time', (SELECT id_campus FROM campus WHERE ubicacion='Madrid')),
('Septiembre 24', '2024-09-23', '2024-12-13','Full Time', (SELECT id_campus FROM campus WHERE ubicacion='Madrid'));


INSERT INTO profesores (nombre_profesor, apellido_profesor , edad, pronombre, email, id_campus)
VALUES 
('Juan', 'Pérez', 35, 'él', 'juan.perez@ejemplo.com', (SELECT id_campus FROM campus WHERE ubicacion='Madrid')),
('Ana', 'García', 30, 'ella', 'ana.garcia@ejemplo.com', (SELECT id_campus FROM campus WHERE ubicacion='Valencia'));

INSERT INTO cursos (bootcamp, aula, presencialidad, id_profesor, id_promocion)
VALUES 
('Full Stack', 'Aula 101', 'Presencial', 1, 1),
('Data Science','Null', 'Online',2, 2);

INSERT INTO estudiantes (nombre_estudiante, apellido_estudiante, edad, pronombre, email, id_curso)
VALUES 
('Pedro', 'López', 20, 'él', 'pedro.lopez@ejemplo.com', 1),
('María', 'Sánchez', 22, 'ella', 'maria.sanchez@ejemplo.com', 1);


INSERT INTO proyectos (proyecto, id_curso)
VALUES 
('Proyecto Final Quiz', 1),
('Proyecto Final Desafío', 2);


INSERT INTO calificaciones (calificacion, id_estudiante, id_proyecto)
VALUES 
('Apto', (SELECT id_estudiante FROM estudiantes WHERE email='pedro.lopez@ejemplo.com'), 1),
('No Apto', (SELECT id_estudiante FROM estudiantes WHERE email='maria.sanchez@ejemplo.com'), 1);


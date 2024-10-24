
CREATE TABLE campus (
   id_campus serial PRIMARY KEY,
   ubicacion varchar (100) NOT NULL
);

CREATE TABLE promociones (
    id_promocion serial PRIMARY KEY,
    nombre varchar (50) NOT NULL,
    full_part_time varchar (50) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_final DATE NOT NULL,
    id_campus int
);

CREATE TABLE profesores (
    id_profesor serial PRIMARY KEY,
    nombre varchar (50) NOT NULL,
    apellido varchar (50) NOT NULL,
    edad int NOT NULL,
    pronombre varchar (20) NOT NULL,
    email varchar (50) NOT NULL UNIQUE,
    id_curso int,
    id_campus int
);

CREATE TABLE cursos (
    id_curso serial PRIMARY KEY,
    materia varchar (50) NOT NULL,
    aula varchar (50) NOT NULL,
    presencial_online varchar (50) NOT NULL,
    id_profesor int,
    id_promocion int
);

CREATE TABLE estudiantes (
    id_estudiante serial PRIMARY KEY,
    nombre varchar (50) NOT NULL,
    apellido varchar (50) NOT NULL,
    edad int NOT NULL,
    pronombre varchar (20) NOT NULL,
    email varchar (50) NOT NULL UNIQUE,
    id_curso int
);

CREATE TABLE proyectos (
    id_proyecto serial PRIMARY KEY,
    nombre varchar (50) NOT NULL,
    id_calificacion int,
    id_curso int
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

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
('Septiembre 24', '2024-09-23', '2024-12-13','Full Time', (SELECT id_campus FROM campus WHERE ubicacion='Madrid'));


INSERT INTO profesores (nombre_profesor, apellido_profesor , edad, pronombre, email, id_campus)
VALUES 
('Juan', 'Pérez', 35, 'él', 'juan.perez@ejemplo.com', (SELECT id_campus FROM campus WHERE ubicacion='Madrid')),
('Ana', 'García', 30, 'ella', 'ana.garcia@ejemplo.com', (SELECT id_campus FROM campus WHERE ubicacion='Valencia')),
('Ana', 'López', 29, 'ella', 'ana.lopez@bootcamp.com', (SELECT id_campus FROM campus WHERE ubicacion='Madrid')),
('Raúl', 'Torres', 38, 'él', 'raul.torres@bootcamp.com', (SELECT id_campus FROM campus WHERE ubicacion='Valencia')),
('Sara', 'Pérez', 32, 'ella', 'sara.perez@bootcamp.com', (SELECT id_campus FROM campus WHERE ubicacion='Madrid')),
('Mario', 'Fernández', 42, 'él', 'mario.fernandez@bootcamp.com', (SELECT id_campus FROM campus WHERE ubicacion='Madrid'));

INSERT INTO cursos (bootcamp, aula, presencialidad, id_profesor, id_promocion)
VALUES 
('Full Stack', 'Aula 101', 'Presencial', 1, 1),
('Full Stack', 'Aula 201', 'Presencial', 1, 2),
('Data Science','Null', 'Online',3, 1),
('Data Science','Aula 204', 'Presencial',3, 3),
('Machine Learning', 'Aula 505', 'Presencial', 2, 1),
('Backend Development', 'Null', 'Online', 4, 2);

INSERT INTO estudiantes (nombre_estudiante, apellido_estudiante, edad, pronombre, email, id_curso)
VALUES 
('Pedro', 'López', 20, 'elle', 'pedro.lopez@ejemplo.com', 1),
('María', 'Sánchez', 22, 'ella', 'maria.sanchez@ejemplo.com', 1),
('María', 'Fernández', 25, 'ella', 'maria.fernandez@bootcamp.com', 1),
('Pablo', 'Sánchez', 28, 'él', 'pablo.sanchez@bootcamp.com', 2),
('Lucía', 'Vega', 22, 'elle', 'lucia.vega@bootcamp.com', 2),
('David', 'García', 30, 'él', 'david.garcia@bootcamp.com', 2),
('Raquel', 'Martín', 27, 'ella', 'raquel.martin@bootcamp.com', 2),
('Jorge', 'Navarro', 29, 'él', 'jorge.navarro@bootcamp.com', 2),
('Laura', 'Pérez', 26, 'elle', 'laura.perez@bootcamp.com', 1),
('Alberto', 'López', 31, 'él', 'alberto.lopez@bootcamp.com', 1),
('Sofía', 'Ramos', 23, 'ella', 'sofia.ramos@bootcamp.com', 1),
('Iván', 'Díaz', 33, 'él', 'ivan.diaz@bootcamp.com', 1),
('Clara', 'Gómez', 21, 'ella', 'clara.gomez@bootcamp.com', 2),
('Luis', 'Mendoza', 34, 'elle', 'luis.mendoza@bootcamp.com', 2),
('Elena', 'Castillo', 24, 'ella', 'elena.castillo@bootcamp.com', 3),
('Miguel', 'Prieto', 32, 'él', 'miguel.prieto@bootcamp.com', 3),
('Carolina', 'Ortiz', 27, 'ella', 'carolina.ortiz@bootcamp.com', 3),
('Rafael', 'Suárez', 36, 'él', 'rafael.suarez@bootcamp.com', 3),
('Natalia', 'Reyes', 23, 'ella', 'natalia.reyes@bootcamp.com', 3),
('José', 'Aguilar', 28, 'él', 'jose.aguilar@bootcamp.com', 3),
('Isabel', 'García', 30, 'ella', 'isabel.garcia@bootcamp.com', 3),
('Daniel', 'Martínez', 26, 'él', 'daniel.martinez@bootcamp.com', 4),
('Cristina', 'Romero', 25, 'ella', 'cristina.romero@bootcamp.com', 4),
('Hugo', 'Serrano', 27, 'él', 'hugo.serrano@bootcamp.com', 4),
('Marta', 'Torres', 28, 'ella', 'marta.torres@bootcamp.com', 4),
('Fernando', 'Cano', 32, 'él', 'fernando.cano@bootcamp.com', 5),
('Marcos', 'Morales', 34, 'él', 'marcos.morales@bootcamp.com', 5),
('Julia', 'Rubio', 22, 'ella', 'julia.rubio@bootcamp.com', 5),
('Adrián', 'Ruiz', 31, 'él', 'adrian.ruiz@bootcamp.com', 5),
('Esther', 'Rivas', 29, 'ella', 'esther.rivas@bootcamp.com', 5),
('Ángel', 'Castro', 30, 'él', 'angel.castro@bootcamp.com', 6),
('Silvia', 'Moreno', 24, 'ella', 'silvia.moreno@bootcamp.com', 6),
('Lucas', 'Gómez', 22, 'él', 'lucas.gomez@email.com', 1),
('Sofía', 'Martínez', 23, 'ella', 'sofia.martinez@email.com', 2);


INSERT INTO proyectos (proyecto, id_curso)
VALUES 
('Proyecto Final Quiz', 1),
('Proyecto Final Quiz', 2),
('Proyecto Final Quiz', 3),
('Proyecto Final Desafío', 2),
('Landing Page', 1),
('Modelo Predictivo', 2),
('Sistema de Monitoreo de Seguridad', 3),
('Prototipo UX/UI', 4),
('Clasificación de Imágenes', 5),
('API de Backend', 4),
('SPA Frontend', 2),
('Pipeline DevOps', 3),
('Aplicación Móvil', 6),
('Arquitectura Cloud', 4),
('ETL de Datos', 5),
('Contrato Blockchain', 2);

INSERT INTO calificaciones (calificacion, id_estudiante, id_proyecto)
VALUES 
('Apto', (SELECT id_estudiante FROM estudiantes WHERE email='maria.fernandez@bootcamp.com'), 1),
('Apto', (SELECT id_estudiante FROM estudiantes WHERE email='pablo.sanchez@bootcamp.com'), 2),
('Apto', (SELECT id_estudiante FROM estudiantes WHERE email='lucia.vega@bootcamp.com'), 2),
('No Apto', (SELECT id_estudiante FROM estudiantes WHERE email='david.garcia@bootcamp.com'), 6),
('Apto', (SELECT id_estudiante FROM estudiantes WHERE email='raquel.martin@bootcamp.com'), 7),
('No Apto', (SELECT id_estudiante FROM estudiantes WHERE email='jorge.navarro@bootcamp.com'), 6),
('Apto', (SELECT id_estudiante FROM estudiantes WHERE email='laura.perez@bootcamp.com'), 5),
('Apto', (SELECT id_estudiante FROM estudiantes WHERE email='alberto.lopez@bootcamp.com'), 5),
('No Apto', (SELECT id_estudiante FROM estudiantes WHERE email='sofia.ramos@bootcamp.com'), 1),
('Apto', (SELECT id_estudiante FROM estudiantes WHERE email='ivan.diaz@bootcamp.com'), 1),
('Apto', (SELECT id_estudiante FROM estudiantes WHERE email='clara.gomez@bootcamp.com'), 2),
('No Apto', (SELECT id_estudiante FROM estudiantes WHERE email='luis.mendoza@bootcamp.com'), 2),
('Apto', (SELECT id_estudiante FROM estudiantes WHERE email='elena.castillo@bootcamp.com'), 3),
('Apto', (SELECT id_estudiante FROM estudiantes WHERE email='miguel.prieto@bootcamp.com'), 8),
('Apto', (SELECT id_estudiante FROM estudiantes WHERE email='carolina.ortiz@bootcamp.com'), 7),
('No Apto', (SELECT id_estudiante FROM estudiantes WHERE email='rafael.suarez@bootcamp.com'), 8),
('Apto', (SELECT id_estudiante FROM estudiantes WHERE email='natalia.reyes@bootcamp.com'), 7),
('Apto', (SELECT id_estudiante FROM estudiantes WHERE email='jose.aguilar@bootcamp.com'), 7),
('No Apto', (SELECT id_estudiante FROM estudiantes WHERE email='isabel.garcia@bootcamp.com'), 7),
('Apto', (SELECT id_estudiante FROM estudiantes WHERE email='daniel.martinez@bootcamp.com'), 9),
('Apto', (SELECT id_estudiante FROM estudiantes WHERE email='cristina.romero@bootcamp.com'), 10),
('No Apto', (SELECT id_estudiante FROM estudiantes WHERE email='hugo.serrano@bootcamp.com'), 10),
('Apto', (SELECT id_estudiante FROM estudiantes WHERE email='marta.torres@bootcamp.com'), 9),
('Apto', (SELECT id_estudiante FROM estudiantes WHERE email='fernando.cano@bootcamp.com'), 11),
('No Apto', (SELECT id_estudiante FROM estudiantes WHERE email='marcos.morales@bootcamp.com'), 11),
('Apto', (SELECT id_estudiante FROM estudiantes WHERE email='julia.rubio@bootcamp.com'), 11),
('Apto', (SELECT id_estudiante FROM estudiantes WHERE email='adrian.ruiz@bootcamp.com'), 11),
('No Apto', (SELECT id_estudiante FROM estudiantes WHERE email='esther.rivas@bootcamp.com'), 11),
('Apto', (SELECT id_estudiante FROM estudiantes WHERE email='angel.castro@bootcamp.com'), 12),
('No Apto', (SELECT id_estudiante FROM estudiantes WHERE email='silvia.moreno@bootcamp.com'), 12),
('Apto', (SELECT id_estudiante FROM estudiantes WHERE email='lucas.gomez@email.com'), 1),
('Apto', (SELECT id_estudiante FROM estudiantes WHERE email='sofia.martinez@email.com'), 2);


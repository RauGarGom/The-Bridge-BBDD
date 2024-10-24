# 🎓 The-Bridge-BBDD

**Base de Datos PostgreSQL con Docker para el Sistema de Gestión de un Bootcamp**

Este proyecto configura una base de datos **PostgreSQL** utilizando **Docker**, destinada a la gestión de la información de un bootcamp. El sistema abarca múltiples entidades como campus, promociones, profesores, estudiantes, cursos, proyectos y calificaciones.

---

## 🚀 Tecnologías Utilizadas

- **PostgreSQL**: Sistema de gestión de bases de datos relacional.
- **pgAdmin**: Herramienta gráfica para gestionar la base de datos PostgreSQL.
- **Render** 

---

## 🗂️ Esquema de la Base de Datos

La base de datos se organiza en las siguientes tablas:

- **`campus`**: Almacena las ubicaciones de los diferentes campus del bootcamp.
- **`promociones`**: Contiene información sobre las promociones y sus horarios.
- **`profesores`**: Almacena los datos de los profesores del bootcamp.
- **`cursos`**: Gestiona los cursos que se imparten en el bootcamp.
- **`estudiantes`**: Almacena la información de los estudiantes.
- **`proyectos`**: Contiene los proyectos realizados por los estudiantes.
- **`calificaciones`**: Registra las calificaciones obtenidas por los estudiantes en sus proyectos.

---

## 📊 Diagrama Entidad-Relación

A continuación, se incluirán **dos diagramas** que ilustran la organización de las tablas y sus relaciones:

1. **Modelo Relacional**: Muestra cómo se relacionan las distintas entidades (tablas) del sistema.

![tablas](https://github.com/user-attachments/assets/e6a411b2-725d-47fa-8621-f8354c42c87a)


2. **Diagrama de entidad Relación**: Muestra los atributos principales de cada tabla y sus relaciones de claves primarias y foráneas.

![MODELO1](https://github.com/user-attachments/assets/50c15796-b3b5-4147-a53e-99bfe1491296)


## 📋 Estructura de Tablas

A continuación se presenta el esquema SQL de cada tabla:

```sql
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

```
## Alter TABLE ✏️

```sql
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
```
## QUERIES 🔍
Algunos ejemplos de consultas que puedes realizar sobre esta base de datos:

```sql
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
```
---
## 🧪 Intento de Implementación del Front-End

Como parte del desarrollo de este proyecto, se realizó un ensayo para implementar una interfaz de usuario utilizando HTML, CSS y JavaScript, con el objetivo de interactuar con nuestra base de datos PostgreSQL. Se implementaron métodos de **fetch** para realizar solicitudes a la API, manejando adecuadamente las respuestas y errores.

### Implementación de Fetch

Se crearon las siguientes funciones clave para interactuar con la base de datos:

- **GET**: Para obtener datos de las tablas de la base de datos.
- **POST**: Para enviar nuevos datos a las tablas.
- **PUT**: Para actualizar registros existentes.
- **DELETE**: Para eliminar registros.

Ejemplo de uso de `fetch`:

```javascript
// Ejemplo de una solicitud GET para obtener estudiantes
    <script>
        // Function to fetch data from the API
        function fetchCampusData() {
            fetch('http://localhost:5000/campus_all')
                .then(response => response.json())
                .then(data => {
                    const dataList = document.getElementById('campus-data-list'); // UPDATE THE CSS CHECK THE BUTTONS
                    dataList.innerHTML = ''; // Clear previous data
                    data.forEach(item => {
                        const listItem = document.createElement('li');
                        listItem.textContent = item.column_name; // Pendiente 
                        dataList.appendChild(listItem);
                    });
                })
                .catch(error => console.error('Error fetching data:', error));
        }

        // Event listener for the button
        document.getElementById('fetch-campus-data').addEventListener('click', fetchCampusData);
    </script>

    
// Conexión no lograda y un ejemplo de HTTP GET
const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');

// Create a pool to connect to PostgreSQL using your database credentials
const pool = new Pool({
  user: 'bbdd_the_bridge_user',
  host: 'dpg-csbscb3tq21c73a7frmg-a.frankfurt-postgres.render.com',
  database: 'bbdd_the_bridge',
  password: 'wpttc3G8kaG6spvrF3WVFhAd3J6cpLZt',
  port: 5432,
  ssl: { rejectUnauthorized: false } // Secure SSL connection, posible error aqui.
});

const app = express();
app.use(cors());
app.use(express.json());

app.get('/campus_all', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM campus');  // CREAR LOS ENDPOINTS, HACER VARIOS FETCH Y QUIZA VARIOS BUTTONS ...??¿¿¿  
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Database error_campus' });
  }
});

// Start the server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));

```

### 4 The Future 😊

A pesar de los esfuerzos realizados, encontramos dificultades relacionadas con la conexión entre el front-end y la base de datos, que se encuentra desplegada en Render/PostgreSQL dentro de un contenedor de Docker. Se sospecha que esto puede deberse a conflictos en la autenticación de la respuesta de PostgreSQL (SSL).

#### Conclusión

Debido a limitaciones de tiempo, no hemos podido realizar pruebas exhaustivas para verificar si efectivamente se trata de un problema de autenticación o configuración de SSL. Es un área que requiere más atención en futuras iteraciones del proyecto.

### 4 The Future 😊 v2!!!
Implentar entidad TA para hacer un 1:M
![4thefutureTA](https://github.com/user-attachments/assets/14eff211-8d3d-4c21-8b1c-c6c392bba453)

---

## 🧑‍💻 Población de las Tablas con Datos de Ejemplo

Para poblar las tablas con datos ficticios, puedes usar las sentencias SQL de inserción de datos proporcionadas. Aquí un ejemplo para la tabla `campus`:

```sql
INSERT INTO campus (ubicacion) VALUES ('Madrid'), ('Barcelona'), ('Valencia');
```

Repite este proceso para las demás tablas.

---

## 📜 Licencia

Este proyecto está bajo la licencia **MIT**. Consulta el archivo [LICENSE](LICENSE) para más información.
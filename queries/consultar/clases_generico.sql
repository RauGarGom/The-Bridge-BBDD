select estudiantes.nombre_estudiante || ' ' || estudiantes.apellido_estudiante, estudiantes.edad, estudiantes.pronombre, estudiantes.email, cursos.bootcamp, cursos.aula, cursos.presencialidad, promociones.promocion, promociones.temporalidad, promociones.fecha_inicio, promociones.fecha_final, campus.ubicacion AS Campus, proyectos.proyecto, calificaciones.calificacion
from estudiantes
join cursos on cursos.id_curso = estudiantes.id_curso
join promociones on cursos.id_promocion = promociones.id_promocion
join campus on campus.id_campus = promociones.id_campus
join calificaciones on estudiantes.id_estudiante = calificaciones.id_estudiante
join proyectos on proyectos.id_proyecto = calificaciones.id_proyecto
SELECT 
    profesores.nombre_profesor || ' ' || profesores.apellido_profesor AS Nombre_Profesor, 
    profesores.edad,
	profesores.pronombre,
    promociones.promocion, 
    cursos.bootcamp, 
    campus.ubicacion, 
    cursos.presencialidad, 
    profesores.email
FROM 
    profesores
INNER JOIN campus ON campus.id_campus = profesores.id_campus
INNER JOIN promociones ON promociones.id_campus = campus.id_campus
INNER JOIN cursos ON cursos.id_profesor = profesores.id_profesor
where campus.ubicacion like 'Madrid'
GROUP BY profesores.nombre_profesor, profesores.apellido_profesor, profesores.edad, profesores.pronombre, promociones.promocion, cursos.bootcamp, campus.ubicacion, cursos.presencialidad, profesores.email
ORDER BY 
    promociones.promocion;

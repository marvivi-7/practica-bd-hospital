-- 1. Proyección: Ver solo los nombres y apellidos de los pacientes
SELECT nombre, apellido FROM Paciente;

-- 2. Selección: Buscar pacientes cuyo nombre sea 'Juan'
SELECT * FROM Paciente WHERE nombre = 'Juan';

-- 3. Unión: Obtener una lista de nombres de médicos y pacientes (ejemplo de unión simple)
SELECT nombre FROM Medico UNION SELECT nombre FROM Paciente;

-- 4. Reunión (Join): Ver qué médico atendió a qué paciente
SELECT P.nombre AS Paciente, M.nombre AS Medico 
FROM Cita C
JOIN Paciente P ON C.id_paciente = P.id_paciente
JOIN Medico M ON C.id_medico = M.id_medico;

-- 5. Diferencia: Médicos que NO tienen citas registradas (usando LEFT JOIN)
SELECT M.nombre 
FROM Medico M
LEFT JOIN Cita C ON M.id_medico = C.id_medico
WHERE C.id_cita IS NULL;

-- 6. Agregación: Total de citas por médico
SELECT id_medico, COUNT(*) as total_citas 
FROM Cita GROUP BY id_medico;

-- 7. Agregación: Costo promedio de los tratamientos por especialidad
SELECT E.nombre_esp, AVG(T.costo) as promedio_costo
FROM Tratamiento T
JOIN Cita C ON T.id_cita = C.id_cita
JOIN Medico M ON C.id_medico = M.id_medico
JOIN Especialidad E ON M.id_especialidad = E.id_especialidad
GROUP BY E.nombre_esp;

-- 8. Agregación: Suma total de lo que ha gastado cada paciente en tratamientos
SELECT P.nombre, P.apellido, SUM(T.costo) as gasto_total
FROM Paciente P
JOIN Cita C ON P.id_paciente = C.id_paciente
JOIN Tratamiento T ON C.id_cita = T.id_cita
GROUP BY P.id_paciente;

-- 9. Operador de División (Médicos que han atendido TODAS las especialidades - concepto):
-- Para esto, buscamos médicos que tengan una cantidad de especialidades igual al total
SELECT id_medico FROM Medico 
GROUP BY id_medico 
HAVING COUNT(DISTINCT id_especialidad) = (SELECT COUNT(*) FROM Especialidad);

-- 10. Agregación: Contar cuántos medicamentos distintos tiene cada receta
SELECT id_cita, COUNT(id_medicamento) as num_medicamentos
FROM Receta GROUP BY id_cita;

-- 11. Cálculo (Existencia): Pacientes que han tenido al menos una cita
SELECT * FROM Paciente P WHERE EXISTS (SELECT 1 FROM Cita C WHERE C.id_paciente = P.id_paciente);

-- 12. Cálculo (Negación): Pacientes que NUNCA han tenido una cita
SELECT * FROM Paciente P WHERE NOT EXISTS (SELECT 1 FROM Cita C WHERE C.id_paciente = P.id_paciente);

-- 13. Reunión Natural: Listar médicos con su departamento
SELECT M.nombre, D.nombre_depto FROM Medico M JOIN Departamento D ON M.id_departamento = D.id_departamento;

-- 14. Filtro Avanzado: Especialidades con costo mayor a 500
SELECT * FROM Especialidad WHERE costo_consulta > 500;

-- 15. Ordenamiento: Médicos ordenados por apellido
SELECT * FROM Medico ORDER BY apellido ASC;

-- 16. Unión compleja: Pacientes y médicos en una sola lista con su rol
SELECT nombre, 'Paciente' as rol FROM Paciente UNION SELECT nombre, 'Medico' FROM Medico;

-- 17. Subconsulta: Médicos que pertenecen a un departamento específico
SELECT * FROM Medico WHERE id_departamento IN (SELECT id_departamento FROM Departamento WHERE nombre_depto = 'Cardiologia');

-- 18. Agregación: Medicamentos más caros
SELECT nombre_comercial, precio_unitario FROM Medicamento WHERE precio_unitario > (SELECT AVG(precio_unitario) FROM Medicamento);

-- 19. Consulta con fecha: Citas programadas en una fecha específica
SELECT * FROM Cita WHERE fecha = '2026-06-15';

-- 20. División/Agrupación: Médicos que han recetado más de 5 veces
SELECT id_medico, COUNT(*) as recetas_emitidas FROM Cita C JOIN Receta R ON C.id_cita = R.id_cita GROUP BY id_medico HAVING COUNT(*) > 5;
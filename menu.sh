#!/bin/bash

ejecutar() {
    echo -e "\n--- EJECUTANDO: $1 ---"
    docker exec 62b096a68a97 mysql -uroot -proot -D hospital_db -e "$2"
}

while true; do
    clear 
    echo -e "      --MENÚ DE CONSULTAS DEL HOSPITAL--       "  
    echo -e "\n[BLOQUE 1: OPERADORES BÁSICOS (π, σ, ∪, ∩, -)]"
    echo "1. Proyección de pacientes (π)"
    echo "2. Filtrar por nombre (σ)"
    echo "3. Unión de nombres (∪)"
    echo "4. Intersección (∩ - vía INNER JOIN)"
    echo "5. Diferencia: Médicos sin citas (-)"
    
    echo -e "\n[BLOQUE 2: REUNIONES (JOINs: ⨝, ⟕, ⟖, ⟗)]"
    echo "6. Médicos y sus departamentos (⨝)"
    echo "7. Citas detalladas con Pacientes (⨝)"
    echo "8. Pacientes con sus tratamientos (⟕)"
    echo "9. Especialidades sin médicos asignados (⟖)"
    echo "10. Lista completa de citas (⟗)"
    
    echo -e "\n[BLOQUE 3: AGREGACIÓN (γ)]"
    echo "11. Total de citas por médico"
    echo "12. Promedio costo por especialidad"
    echo "13. Gasto total por paciente"
    echo "14. Medicamentos por receta"
    echo "15. Especialidades caras (> Promedio)"
    
    echo -e "\n[BLOQUE 4: DIVISIÓN (÷)]"
    echo "16. Médicos que cubren todas las especialidades"
    echo "17. Pacientes que han tenido todos los tratamientos"
    echo "18. Citas que incluyen todos los medicamentos"
    
    echo -e "\n[BLOQUE 5: CUANTIFICADORES (∀, ∃)]"
    echo "19. Pacientes con al menos una cita (∃)"
    echo "20. Pacientes sin ninguna cita (∀)"
    
    echo -e "\ns. Salir"
    echo -e "-----------------------------------"
    read -p "Selecciona una opción: " op
    
    # Si elige salir desde el menú principal
    if [[ "$op" == "s" || "$op" == "S" ]]; then
        echo "Saliendo..."
        exit 0
    fi
    
    case $op in
        1) ejecutar "Proyección Pacientes" "SELECT nombre, apellido FROM Paciente;" ;;
        2) ejecutar "Selección por Nombre" "SELECT * FROM Paciente WHERE nombre = 'Juan';" ;;
        3) ejecutar "Unión Médicos/Pacientes" "SELECT nombre FROM Medico UNION SELECT nombre FROM Paciente;" ;;
        4) ejecutar "Intersección" "SELECT M.nombre FROM Medico M INNER JOIN Cita C ON M.id_medico = C.id_medico;" ;;
        5) ejecutar "Diferencia" "SELECT M.nombre FROM Medico M LEFT JOIN Cita C ON M.id_medico = C.id_medico WHERE C.id_cita IS NULL;" ;;
        6) ejecutar "Join Médicos-Deptos" "SELECT M.nombre, D.nombre_depto FROM Medico M JOIN Departamento D ON M.id_departamento = D.id_departamento;" ;;
        7) ejecutar "Join Citas-Pacientes" "SELECT C.id_cita, P.nombre FROM Cita C JOIN Paciente P ON C.id_paciente = P.id_paciente;" ;;
        8) ejecutar "Left Join Pacientes-Tratamientos" "SELECT P.nombre, T.tipo_procedimiento FROM Paciente P LEFT JOIN Cita C ON P.id_paciente = C.id_paciente LEFT JOIN Tratamiento T ON C.id_cita = T.id_cita;" ;;
        9) ejecutar "Right Join Especialidad-Médico" "SELECT E.nombre_esp, M.nombre FROM Medico M RIGHT JOIN Especialidad E ON M.id_especialidad = E.id_especialidad WHERE M.id_medico IS NULL;" ;;
        10) ejecutar "Full Outer Join (Simulado)" "SELECT P.nombre, C.fecha FROM Paciente P LEFT JOIN Cita C ON P.id_paciente = C.id_paciente UNION SELECT P.nombre, C.fecha FROM Paciente P RIGHT JOIN Cita C ON P.id_paciente = C.id_paciente;" ;;
        11) ejecutar "Total Citas por Médico" "SELECT id_medico, COUNT(*) FROM Cita GROUP BY id_medico;" ;;
        12) ejecutar "Costo Promedio Especialidad" "SELECT E.nombre_esp, AVG(T.costo) FROM Tratamiento T JOIN Cita C ON T.id_cita = C.id_cita JOIN Medico M ON C.id_medico = M.id_medico JOIN Especialidad E ON M.id_especialidad = E.id_especialidad GROUP BY E.nombre_esp;" ;;
        13) ejecutar "Gasto por Paciente" "SELECT P.nombre, SUM(T.costo) FROM Paciente P JOIN Cita C ON P.id_paciente = C.id_paciente JOIN Tratamiento T ON C.id_cita = T.id_cita GROUP BY P.id_paciente;" ;;
        14) ejecutar "Medicamentos por Receta" "SELECT id_cita, COUNT(id_medicamento) FROM Receta GROUP BY id_cita;" ;;
        15) ejecutar "Especialidades caras" "SELECT nombre_esp, costo_consulta FROM Especialidad WHERE costo_consulta > (SELECT AVG(costo_consulta) FROM Especialidad);" ;;
        16) ejecutar "División Médicos-Esp" "SELECT id_medico FROM Medico GROUP BY id_medico HAVING COUNT(DISTINCT id_especialidad) = (SELECT COUNT(*) FROM Especialidad);" ;;
        17) ejecutar "División Paciente-Tratamiento" "SELECT id_paciente FROM Cita GROUP BY id_paciente HAVING COUNT(DISTINCT id_cita) = (SELECT COUNT(*) FROM Cita);" ;;
        18) ejecutar "División Cita-Medicamento" "SELECT id_cita FROM Receta GROUP BY id_cita HAVING COUNT(DISTINCT id_medicamento) = (SELECT COUNT(*) FROM Medicamento);" ;;
        19) ejecutar "Pacientes con cita (Exist)" "SELECT * FROM Paciente P WHERE EXISTS (SELECT 1 FROM Cita C WHERE C.id_paciente = P.id_paciente);" ;;
        20) ejecutar "Pacientes sin cita (Not Exist)" "SELECT * FROM Paciente P WHERE NOT EXISTS (SELECT 1 FROM Cita C WHERE C.id_paciente = P.id_paciente);" ;;
        *) echo "Opción no válida." ;;
    esac

    echo -e "\n-----------------------------------------------------------"
    read -p "Presiona [ENTER] para elegir otra consulta o escribe 's' para salir: " post_op
    
    if [[ "$post_op" == "s" || "$post_op" == "S" ]]; then
        echo "Saliendo del sistema..."
        exit 0
    fi
done
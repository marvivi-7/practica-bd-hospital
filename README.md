#  Sistema de Gestión Hospitalaria

## Integrantes:
* Mariel Torres Hernández
* [Nombre de Integrante 2]

---

## Descripción del dominio del problema:
Nuestro proyecto implementa una solución de base de datos relacional para optimizar la gestión operativa y clínica de un centro hospitalario. El sistema resuelve de manera integral el control de flujos de pacientes, la asignación de personal médico por departamentos y la trazabilidad de consultas, tratamientos y recetas emitidas.

### Reglas de Negocio Incorporadas:
1. **Estructura Administrativa:** El hospital se organiza en Departamentos. Cada Médico pertenece a un único departamento y cuenta con una Especialidad que define el costo base de sus honorarios.
2. **Flujo de Atención:** Los Pacientes programan Citas con médicos específicos en fechas determinadas. Una cita vincula obligatoriamente a un paciente con un médico.
3. **Entidades Clínicas y Financieras:** Cada cita genera un Tratamiento (procedimiento realizado y su costo) y una Receta. La receta actúa como entidad puente para asociar la consulta con uno o varios Medicamentos específicos y sus precios unitarios.

---

##  Diseño de la BD:

### 1. Diagrama Entidad-Relación Extendido (EER)

<img src="https://github.com/user-attachments/assets/b8144e90-c3c9-45f3-9b40-9506d29966e1" alt="Diagrama Entidad-Relación Extendido" width="100%" />

### 2. Modelo Relacional

<img src="https://github.com/user-attachments/assets/69e125da-3f20-45b5-a0cc-580241cfe39c" alt="Modelo Relacional del Sistema" width="100%" />

###  Descripción General:

El modelado de nuestra base de datos se diseñó para conectar de forma limpia toda la operación clínica y administrativa del centro médico, estructurando primero un Diagrama Entidad-Relación Extendido que define cómo los departamentos y las especialidades determinan el control del personal médico para luego ligarlos directamente con el flujo de los pacientes a través de citas, las cuales disparan de manera obligatoria un tratamiento clínico con sus costos asociados y una receta médica que sirve como puente para la dosificación de los medicamentos, logrando transformar todo este mapa conceptual en un Modelo Relacional  que elimina cualquier riesgo de redundancia de datos y asegura que el servidor responda con total consistencia y velocidad a cada una de las 20 consultas analíticas del álgebra relacional implementadas en el menú interactivo.

---

##  Instrucciones de Instalación, Configuración y Ejecución:

Este ecosistema está completamente contenedorizado bajo **Docker** y **Docker Compose**, lo que asegura un despliegue idéntico y funcional en cualquier sistema operativo.

### Prerrequisitos:
* **Docker Desktop** activo y en ejecución.
* Terminal compatible con Bash (**Git Bash** recomendado).

### Paso 1: Clonar el Proyecto
Abre la terminal de tu computadora y ejecuta estos comandos para descargar el repositorio y entrar directamente a la carpeta del proyecto:
    git clone link-del-repositorio-que-clonaste
    después ejecuta este comando:
    cd practica-bd-hospital

### Paso 2: Iniciar la Base de Datos
Primero asegúrate de tener la aplicación de Docker Desktop abierta en tu computadora. Después, en la misma terminal y dentro de la carpeta del proyecto, ejecuta este comando para encender el servidor de MySQL en segundo plano:
    docker-compose up -d

### Paso 3: Cargar los Datos de Prueba
Para llenar las tablas con los registros de ejemplo, ejecuta este comando en la terminal (asegúrate de seguir en la carpeta del proyecto para que encuentre el archivo `datos.sql`):
    docker-compose exec -T db mysql -uroot -proot -D hospital_db < datos.sql

### Paso 4: Ejecutar el Menú de Consultas
Para abrir el menú interactivo en la terminal y empezar a probar las consultas del álgebra relacional, corre este comando:
    bash menu.sh

---

## Álgebra Relacional y operaciones utilizadas:

La siguiente tabla funciona como una guía rápida para ver cómo se conectan los símbolos teóricos de la materia con el código real que programamos en el menú interactivo:

| Bloque Académico | Operador de Álgebra Relacional | Mapeo Práctico en SQL |
| :--- | :---: | :--- |
| **Bloque 1: Operadores Básicos** | Proyección ($\pi$) <br> Selección ($\sigma$) <br> Unión ($\cup$) <br> Intersección ($\cap$) <br> Diferencia ($-$) | `SELECT COLUMNAS` <br> `WHERE CONDICION` <br> `UNION` <br> `INNER JOIN` <br> `LEFT JOIN ... WHERE NULL` |
| **Bloque 2: Reuniones** | Joins ($\bowtie$) | `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `FULL OUTER` |
| **Bloque 3: Agregación** | Agregación ($\gamma$) | `GROUP BY` con funciones `COUNT`, `AVG`, `SUM` y filtros `HAVING` |
| **Bloque 4: División** | División ($\div$) | Restricción de conjuntos mediante `HAVING COUNT(DISTINCT...)` |
| **Bloque 5: Cuantificadores** | Cuantificadores ($\forall, \exists$) | Subconsultas correlacionadas utilizando `EXISTS` y `NOT EXISTS` |

---

### Detalles del Menú Interactivo y Consultas Ejecutadas:

A continuación se desglosan las 20 consultas que corre el script del menú, explicando qué hace cada una en el hospital, el operador que usa y su código exacto:

#### Bloque 1: Operadores Básicos.

* **Consulta 1: Directorio Clínico (Proyección - $\pi$)**
    * **Qué hace:** Obtiene la lista con los nombres, apellidos y las especialidades de todos los médicos que trabajan en el hospital.
    * **Código SQL:**
        ```sql
        SELECT nombre, apellido, id_especialidad FROM MEDICO;
        ```

* **Consulta 2: Filtro de Emergencias (Selección - $\sigma$)**
    * **Qué hace:** Busca y muestra el expediente completo de los pacientes que ingresaron bajo el estado de 'Urgencias'.
    * **Código SQL:**
        ```sql
        SELECT * FROM PACIENTE WHERE tipo_ingreso = 'Urgencias';
        ```

* **Consulta 3: Directorio General Telefónico (Unión - $\cup$)**
    * **Qué hace:** Consolida en una sola lista los nombres y teléfonos tanto de los pacientes como de los médicos para el sistema de avisos masivos.
    * **Código SQL:**
        ```sql
        SELECT nombre, telefono, 'Paciente' AS tipo FROM PACIENTE
        UNION
        SELECT nombre, telefono, 'Medico' AS tipo FROM MEDICO;
        ```

* **Consulta 4: Pacientes con Atención Activa (Intersección - $\cap$)**
    * **Qué hace:** Cruza los datos para identificar los ID de aquellos pacientes que agendaron una cita y que ya tienen un tratamiento asignado.
    * **Código SQL:**
        ```sql
        SELECT id_paciente FROM CITA
        INNER JOIN TRATAMIENTO ON CITA.id_cita = TRATAMIENTO.id_cita;
        ```

* **Consulta 5: Pacientes sin Consultas (Diferencia - $-$)**
    * **Qué hace:** Detecta a los pacientes que fueron registrados en el sistema pero que todavía no han agendado ninguna cita médica.
    * **Código SQL:**
        ```sql
        SELECT PACIENTE.id_paciente, PACIENTE.nombre 
        FROM PACIENTE 
        LEFT JOIN CITA ON PACIENTE.id_paciente = CITA.id_paciente 
        WHERE CITA.id_cita IS NULL;
        ```

#### Bloque 2: Reuniones (Joins).

* **Consulta 6: Bitácora de Citas (Inner Join - $\bowtie$)**
    * **Qué hace:** Cruza las tablas para armar un reporte con la fecha de la cita, el nombre del paciente y el médico que lo atendió.
    * **Código SQL:**
        ```sql
        SELECT CITA.fecha, PACIENTE.nombre AS paciente, MEDICO.nombre AS medico
        FROM CITA
        INNER JOIN PACIENTE ON CITA.id_paciente = PACIENTE.id_paciente
        INNER JOIN MEDICO ON CITA.id_medico = MEDICO.id_medico;
        ```

* **Consulta 7: Asignación de Médicos (Left Join)**
    * **Qué hace:** Lista a todos los médicos junto al nombre de su departamento actual, asegurando incluir a los médicos que aún no tengan un área asignada.
    * **Código SQL:**
        ```sql
        SELECT MEDICO.nombre, DEPARTAMENTO.nombre_depto 
        FROM MEDICO 
        LEFT JOIN DEPARTAMENTO ON MEDICO.id_departmento = DEPARTAMENTO.id_departamento;
        ```

* **Consulta 8: Ocupación por Áreas (Right Join)**
    * **Qué hace:** Muestra todos los departamentos registrados en el hospital junto con los médicos que pertenecen a cada uno, permitiendo ver qué áreas están vacías.
    * **Código SQL:**
        ```sql
        SELECT DEPARTAMENTO.nombre_depto, MEDICO.nombre 
        FROM MEDICO 
        RIGHT JOIN DEPARTAMENTO ON MEDICO.id_departamento = DEPARTAMENTO.id_departamento;
        ```

* **Consulta 9: Reporte Cruzado Absoluto (Full Outer Join)**
    * **Qué hace:** Junta toda la información de pacientes y citas, mostrando tanto a los pacientes con cita como a los que no tienen, e historiales sin datos del paciente asignado.
    * **Código SQL:**
        ```sql
        SELECT PACIENTE.nombre, CITA.id_cita FROM PACIENTE LEFT JOIN CITA ON PACIENTE.id_paciente = CITA.id_paciente
        UNION
        SELECT PACIENTE.nombre, CITA.id_cita FROM PACIENTE RIGHT JOIN CITA ON PACIENTE.id_paciente = CITA.id_paciente;
        ```

* **Consulta 10: Costos de Consulta por Médico (Equi-Join)**
    * **Qué hace:** Une la tabla de médicos con sus especialidades para revisar en cuánto se cobra la consulta de cada doctor del hospital.
    * **Código SQL:**
        ```sql
        SELECT M.nombre, E.nombre_esp, E.costo_consulta 
        FROM MEDICO M 
        INNER JOIN ESPECIALIDAD E ON M.id_especialidad = E.id_especialidad;
        ```

#### Bloque 3: Agregación.

* **Consulta 11: Historial de Frecuencia (Count - $\gamma$)**
    * **Qué hace:** Cuenta cuántas citas totales tiene registradas cada paciente en la base de datos.
    * **Código SQL:**
        ```sql
        SELECT id_paciente, COUNT(*) AS total_citas FROM CITA GROUP BY id_paciente;
        ```

* **Consulta 12: Costo Promedio Médico (Avg)**
    * **Qué hace:** Saca el promedio del costo de las consultas divididas por cada especialidad del hospital.
    * **Código SQL:**
        ```sql
        SELECT id_especialidad, AVG(costo_consulta) AS promedio_costo FROM ESPECIALIDAD GROUP BY id_especialidad;
        ```

* **Consulta 13: Caja Total por Tratamientos (Sum)**
    * **Qué hace:** Suma los montos de absolutamente todos los tratamientos aplicados para obtener los ingresos totales.
    * **Código SQL:**
        ```sql
        SELECT SUM(costo) AS facturacion_total FROM TRATAMIENTO;
        ```

* **Consulta 14: Pacientes Recurrentes (Filtro Having)**
    * **Qué hace:** Cuenta las citas de los pacientes y filtra para mostrar únicamente a los que han venido más de 3 veces.
    * **Código SQL:**
        ```sql
        SELECT id_paciente, COUNT(*) AS total 
        FROM CITA 
        GROUP BY id_paciente 
        HAVING COUNT(*) > 3;
        ```

* **Consulta 15: Monitoreo Financiero por Área (Agregación Compuesta)**
    * **Qué hace:** Agrupa los costos de las especialidades por departamento y filtra para mostrar solo las áreas que generan más de 500 en total.
    * **Código SQL:**
        ```sql
        SELECT M.id_departamento, SUM(E.costo_consulta) AS total_costo
        FROM MEDICO M
        INNER JOIN ESPECIALIDAD E ON M.id_especialidad = E.id_especialidad
        GROUP BY M.id_departamento
        HAVING SUM(E.costo_consulta) > 500;
        ```

#### Bloque 4: División.

* **Consulta 16: Pacientes Multidepartamentales (División - $\div$)**
    * **Qué hace:** Identifica los ID de los pacientes que han tenido consultas en absolutamente todos los departamentos del hospital.
    * **Código SQL:**
        ```sql
        SELECT id_paciente FROM CITA 
        INNER JOIN MEDICO ON CITA.id_medico = MEDICO.id_medico
        GROUP BY id_paciente 
        HAVING COUNT(DISTINCT MEDICO.id_departamento) = (SELECT COUNT(*) FROM DEPARTAMENTO);
        ```

* **Consulta 17: Médicos de Cobertura Total**
    * **Qué hace:** Encuentra a los médicos que han atendido de manera individual a cada uno de los pacientes registrados en el sistema.
    * **Código SQL:**
        ```sql
        SELECT id_medico FROM CITA 
        GROUP BY id_medico 
        HAVING COUNT(DISTINCT id_paciente) = (SELECT COUNT(*) FROM PACIENTE);
        ```

#### Bloque 5: Cuantificadores

* **Consulta 18: Validación de Médicos Activos (Existe - $\exists$)**
    * **Qué hace:** Muestra los nombres de los médicos que tienen al menos una cita asignada en el historial.
    * **Código SQL:**
        ```sql
        SELECT nombre, apellido FROM MEDICO M
        WHERE EXISTS (SELECT 1 FROM CITA C WHERE C.id_medico = M.id_medico);
        ```

* **Consulta 19: Inventario sin Movimiento (No Existe - $\neg\exists$)**
    * **Qué hace:** Revisa el almacén de medicamentos y saca los nombres de los fármacos que nunca se han recetado.
    * **Código SQL:**
        ```sql
        SELECT nombre_comercial FROM MEDICAMENTO M
        WHERE NOT EXISTS (SELECT 1 FROM RECETA R WHERE R.id_medicamento = M.id_medicamento);
        ```

* **Consulta 20: Pacientes con Receta Completa (Para Todo - $\forall$)**
    * **Qué hace:** Filtra y devuelve los datos de los pacientes que tienen todas sus citas médicas con su respectiva receta ya emitida, asegurando que no queden consultas pendientes de medicamento.
    * **Código SQL:**
        ```sql
        SELECT P.nombre, P.apellido FROM PACIENTE P
        WHERE NOT EXISTS (
            SELECT * FROM CITA C 
            WHERE C.id_paciente = P.id_paciente 
            AND NOT EXISTS (
                SELECT * FROM RECETA R WHERE R.id_cita = C.id_cita
            )
        );
        ```

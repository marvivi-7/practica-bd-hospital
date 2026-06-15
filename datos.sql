-- Limpiar datos anteriores por si acaso
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE Receta;
TRUNCATE TABLE Tratamiento;
TRUNCATE TABLE Cita;
TRUNCATE TABLE Paciente;
TRUNCATE TABLE Medico;
TRUNCATE TABLE Especialidad;
TRUNCATE TABLE Departamento;
TRUNCATE TABLE Medicamento;
SET FOREIGN_KEY_CHECKS = 1;

-- 7 Departamentos
INSERT INTO Departamento (id_departamento, nombre_depto) VALUES 
(1, 'Cardiologia'), (2, 'Pediatria'), (3, 'Neurologia'), (4, 'Oncologia'), (5, 'Urgencias'), (6, 'Dermatologia'), (7, 'Psiquiatria');

-- 7 Especialidades
INSERT INTO Especialidad (id_especialidad, nombre_esp, costo_consulta) VALUES 
(1, 'Cirugia', 600), (2, 'General', 300), (3, 'Neurocirugia', 1200), (4, 'Oncologia pediátrica', 900), (5, 'Traumatologia', 500), (6, 'Dermatologia clinica', 400), (7, 'Psicoanalisis', 350);

-- 7 Médicos
INSERT INTO Medico (id_medico, nombre, apellido, id_departamento, id_especialidad) VALUES 
(1, 'Roberto', 'House', 1, 1), (2, 'Meredith', 'Grey', 2, 2), (3, 'Derek', 'Shepherd', 3, 3), 
(4, 'Cristina', 'Yang', 1, 1), (5, 'Miranda', 'Bailey', 2, 2), (6, 'Alex', 'Karev', 2, 2), (7, 'Shaun', 'Murphy', 1, 1);

-- 7 Pacientes
INSERT INTO Paciente (id_paciente, nombre, apellido) VALUES 
(1, 'Juan', 'Perez'), (2, 'Maria', 'Lopez'), (3, 'Carlos', 'Santana'), 
(4, 'Ana', 'Gomez'), (5, 'Luis', 'Miguel'), (6, 'Sofía', 'Vergara'), (7, 'Pedro', 'Pascal');

-- 10 Citas (Para asegurar que los COUNT funcionen)
INSERT INTO Cita (id_cita, id_paciente, id_medico, fecha) VALUES 
(1, 1, 1, '2026-06-15'), (2, 2, 2, '2026-06-16'), (3, 3, 1, '2026-06-15'), 
(4, 4, 1, '2026-06-17'), (5, 5, 1, '2026-06-18'), (6, 6, 1, '2026-06-19'), 
(7, 7, 1, '2026-06-20'), (8, 1, 3, '2026-06-21'), (9, 2, 4, '2026-06-22'), (10, 3, 5, '2026-06-23');

-- 7 Tratamientos
INSERT INTO Tratamiento (id_tratamiento, id_cita, tipo_procedimiento, costo) VALUES 
(1, 1, 'Cirugia', 5000), (2, 2, 'Chequeo', 200), (3, 3, 'Electrocardiograma', 1500), 
(4, 4, 'Examen de sangre', 300), (5, 5, 'Revision', 250), (6, 6, 'Consulta', 200), (7, 7, 'Terapia', 800);

-- 7 Medicamentos
INSERT INTO Medicamento (id_medicamento, nombre_comercial, precio_unitario) VALUES 
(1, 'Aspirina', 50), (2, 'Paracetamol', 100), (3, 'Ibuprofeno', 80), 
(4, 'Amoxicilina', 150), (5, 'Omeprazol', 120), (6, 'Loratadina', 60), (7, 'Diclofenaco', 90);

-- 8 Recetas
INSERT INTO Receta (id_receta, id_cita, id_medicamento) VALUES 
(1, 1, 1), (2, 1, 2), (3, 2, 3), (4, 3, 4), (5, 4, 5), (6, 5, 6), (7, 6, 7), (8, 7, 1);
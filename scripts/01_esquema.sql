CREATE TABLE Departamento (
    id_departamento INT PRIMARY KEY,
    nombre_depto VARCHAR(100) UNIQUE,
    bloque VARCHAR(50),
    piso INT,
    extension_tel VARCHAR(20)
);

CREATE TABLE Especialidad (
    id_especialidad INT PRIMARY KEY,
    nombre_esp VARCHAR(100),
    descripcion TEXT,
    costo_consulta DECIMAL(10,2)
);

CREATE TABLE Medico (
    id_medico INT PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    cedula VARCHAR(50),
    id_especialidad INT,
    id_departamento INT,
    FOREIGN KEY (id_especialidad) REFERENCES Especialidad(id_especialidad),
    FOREIGN KEY (id_departamento) REFERENCES Departamento(id_departamento)
);

CREATE TABLE Paciente (
    id_paciente INT PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    fecha_nacimiento DATE,
    telefono VARCHAR(20)
);

CREATE TABLE Cita (
    id_cita INT PRIMARY KEY,
    fecha DATE,
    hora TIME,
    estado VARCHAR(50),
    id_paciente INT,
    id_medico INT,
    FOREIGN KEY (id_paciente) REFERENCES Paciente(id_paciente),
    FOREIGN KEY (id_medico) REFERENCES Medico(id_medico)
);

CREATE TABLE Tratamiento (
    id_tratamiento INT PRIMARY KEY,
    tipo_procedimiento VARCHAR(100),
    costo DECIMAL(10,2),
    duracion_dias INT,
    id_cita INT,
    FOREIGN KEY (id_cita) REFERENCES Cita(id_cita)
);

CREATE TABLE Medicamento (
    id_medicamento INT PRIMARY KEY,
    nombre_comercial VARCHAR(100),
    formula_activa VARCHAR(100),
    precio_unitario DECIMAL(10,2)
);

CREATE TABLE Receta (
    id_receta INT PRIMARY KEY,
    dosis VARCHAR(50),
    id_cita INT,
    id_medicamento INT,
    FOREIGN KEY (id_cita) REFERENCES Cita(id_cita),
    FOREIGN KEY (id_medicamento) REFERENCES Medicamento(id_medicamento)
);
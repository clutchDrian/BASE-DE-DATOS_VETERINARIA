DROP DATABASE TRABAJOFINALGEREI
CREATE DATABASE TRABAJOFINALGEREI
USE TRABAJOFINALGEREI
--Creacion de tablas fuertes--
CREATE TABLE DUEÑO(
ID_Dueño INT IDENTITY(1,1) PRIMARY KEY,
DNI_C VARCHAR(8) NOT NULL,
Nombre_C VARCHAR(20) NOT NULL,
Apellido_PC VARCHAR(20) NOT NULL,
Apellido_MC VARCHAR(20) NOT NULL,
Direccion_C VARCHAR(20) NOT NULL
);
CREATE TABLE VETERINARIO(
ID_Veterinario INT IDENTITY(1,1) PRIMARY KEY,
Nombre_V VARCHAR(20) NOT NULL,
Apellido_VP VARCHAR(20) NOT NULL,
Apellido_VM VARCHAR(20) NOT NULL,
Num_Acreditacion VARCHAR(15) NOT NULL,
DNI_V VARCHAR(8) NOT NULL
);
CREATE TABLE CUIDADOR(
ID_Cuidador INT IDENTITY(1,1) PRIMARY KEY,
NombresC VARCHAR(20) NOT NULL,
ApellidoPC VARCHAR(20) NOT NULL,
ApellidoMC VARCHAR(20) NOT NULL,
DNIC VARCHAR(8) NOT NULL,
Fecha_Ingreso DATE NOT NULL,
Sueldo Decimal(10,2)
);
CREATE TABLE LABORATORIO(
ID_Laboratorio INT IDENTITY(1,1) PRIMARY KEY,
NombreL VARCHAR(20) NOT NULL,
RUCL VARCHAR(11) NOT NULL,
DireccionL VARCHAR(20) NOT NULL
);
CREATE TABLE TIPO_EXAMENL(
ID_TipoExamenL INT IDENTITY(1,1) PRIMARY KEY,
DescripciónEL VARCHAR(50) NOT NULL,
LugardeArchivoEL VARCHAR(50) NOT NULL,
Precio DECIMAL(10,2) NOT NULL -- Permite números de hasta 5 dígitos en total, de los cuales 2 serán decimales
);
CREATE TABLE TIPO_EXAMENI(
ID_TipoExamenI INT IDENTITY(1,1) PRIMARY KEY,
DescripciónEI VARCHAR(50) NOT NULL,
LugardeArchivoEI VARCHAR(50) NOT NULL,
Precio DECIMAL(10,2) NOT NULL -- Permite números de hasta 5 dígitos en total, de los cuales 2 serán decimales
);
CREATE TABLE MEDICINA(
ID_Medicina INT IDENTITY(1,1) PRIMARY KEY,
DescripcionM VARCHAR(20) NOT NULL,
TipoM VARCHAR(20) NOT NULL,
StockM INT NOT NULL,
PrecioUM Decimal(10,2) NOT NULL
);
CREATE TABLE PRODUCTOS(
ID_Producto INT IDENTITY(1,1) PRIMARY KEY,
PrecioP Decimal(10,2) NOT NULL,
StockP INT NOT NULL,
Tipo_Producto VARCHAR(20) NOT NULL,
Descripcion VARCHAR(50) NOT NULL
);
--Tablas debiles
CREATE TABLE MASCOTA(
ID_Mascota INT IDENTITY(1,1) PRIMARY KEY,
Nombre_M VARCHAR (20) NOT NULL,
Sexo_M char(1) NOT NULL,
Color_M VARCHAR(20) NOT NULL,
Especie_M VARCHAR (20) NOT NULL,
Raza_M VARCHAR(20) NOT NULL,
Edad_M INT NOT NULL,
Fecha_VacM DATE NOT NULL,
Fecha_DesM DATE NOT NULL,
ID_Dueño INT NOT NULL FOREIGN KEY REFERENCES DUEÑO(ID_Dueño)
);
CREATE TABLE BOLETA(
ID_Boleta INT IDENTITY(1,1) PRIMARY KEY,
Total_NetoC DECIMAL(10,2) NOT NULL,
Total_NetoV DECIMAL(10,2) NOT NULL,
Total_NetoSE DECIMAL(10,2) NOT NULL,
Total_Boleta DECIMAL(10,2) NOT NULL,
Fecha_Emision DATE NOT NULL,
IGV DECIMAL(10,2) NOT NULL,
ID_Dueño INT NOT NULL FOREIGN KEY REFERENCES DUEÑO(ID_Dueño),
ID_Mascota INT NOT NULL FOREIGN KEY REFERENCES MASCOTA(ID_MASCOTA)
);
CREATE TABLE CONSULTA(
ID_Consulta INT IDENTITY(1,1) PRIMARY KEY,
Motivo_C VARCHAR(50) NOT NULL,
ID_Veterinario INT NOT NULL FOREIGN KEY REFERENCES
VETERINARIO(ID_Veterinario)
);
CREATE TABLE Anamnesis(
ID_Anamnesis INT IDENTITY(1,1) PRIMARY KEY,
ID_Consulta INT FOREIGN KEY REFERENCES CONSULTA(ID_Consulta),
Sintomas VARCHAR(50)
);
CREATE TABLE EXAMEN_POR_IMAGEN(
ID_ExamenI INT NOT NULL IDENTITY (1,1) PRIMARY KEY,
Tipo_ExamenI INT NOT NULL FOREIGN KEY REFERENCES
Tipo_ExamenI(ID_TipoExamenI),
ID_EILaboratorio INT NOT NULL FOREIGN KEY REFERENCES
LABORATORIO(ID_LABORATORIO),
ID_EICONSULTA INT NOT NULL FOREIGN KEY REFERENCES
CONSULTA(ID_Consulta),
Observaciones VARCHAR(50) NOT NULL,
FechaEI DATE NOT NULL,
NombreEI VARCHAR(50) NOT NULL
);
CREATE TABLE EXAMEN_POR_LABORATORIO(
ID_ExamenL INT NOT NULL IDENTITY (1,1) PRIMARY KEY,
Tipo_ExamenL INT NOT NULL FOREIGN KEY REFERENCES
Tipo_ExamenL(ID_TipoExamenL),
ID_ELaboratorio INT NOT NULL FOREIGN KEY REFERENCES
LABORATORIO(ID_LABORATORIO),
ID_ELCONSULTA INT NOT NULL FOREIGN KEY REFERENCES
CONSULTA(ID_Consulta),
Observaciones VARCHAR(50) NOT NULL,
FechaEL DATE NOT NULL,
NombreEL VARCHAR(50) NOT NULL
);
CREATE TABLE RECETA(
ID_RECETA INT NOT NULL IDENTITY (1,1) PRIMARY KEY,
DIAGNOSTICO VARCHAR(50) NOT NULL,
ID_CONSULTA INT NOT NULL FOREIGN KEY REFERENCES
CONSULTA(ID_CONSULTA)
);
CREATE TABLE SERVICIO_ESTETICO(
ID_ServicioEstetico INT NOT NULL IDENTITY (1,1) PRIMARY KEY,
TipoSE VARCHAR(20) NOT NULL,
Obs VARCHAR(50),
ID_Cuidador INT NOT NULL FOREIGN KEY REFERENCES Cuidador(ID_Cuidador)
);
--TABLAS DE RELACIONES
CREATE TABLE DETALLE_CONSULTA(
ID_DetalleConsulta INT IDENTITY(1,1) NOT NULL,
ID_Consulta INT NOT NULL FOREIGN KEY REFERENCES
CONSULTA(ID_CONSULTA),
ID_BOLETA INT NOT NULL FOREIGN KEY REFERENCES BOLETA(ID_BOLETA),
TOTAL_DETALLEC FLOAT NOT NULL
);
CREATE TABLE DETALLE_SE(
ID_DETALLESE INT IDENTITY(1,1) NOT NULL,
ID_SE INT NOT NULL FOREIGN KEY REFERENCES
SERVICIO_ESTETICO(ID_ServicioEstetico),
ID_BOLETA INT NOT NULL FOREIGN KEY REFERENCES BOLETA(ID_BOLETA),
TOTAL_DETALLESE FLOAT NOT NULL
);
CREATE TABLE DETALLE_VENTA(
ID_DETALLEV INT IDENTITY(1,1) NOT NULL,
ID_PRODUCTO INT NOT NULL FOREIGN KEY REFERENCES
PRODUCTOS(ID_PRODUCTO),
ID_BOLETA INT NOT NULL FOREIGN KEY REFERENCES BOLETA(ID_BOLETA),
CANTIDAD INT NOT NULL,
TOTAL FLOAT NOT NULL
);
CREATE TABLE DETALLE_RECETA(
ID_DRECETA INT IDENTITY(1,1) NOT NULL,
ID_MEDICINA INT NOT NULL FOREIGN KEY REFERENCES
MEDICINA(ID_MEDICINA),
ID_RECETA INT NOT NULL FOREIGN KEY REFERENCES RECETA(ID_RECETA),
CANTIDADM INT NOT NULL,
TOTAL FLOAT NOT NULL
);
-- CHECK CONSTRAINGS
--Asegurar que el stock de productos, medicinas no sea 0
ALTER TABLE PRODUCTOS
ADD CONSTRAINT chk_StockP CHECK (StockP>=0)
ALTER TABLE MEDICINA
ADD CONSTRAINT chk_StockM CHECK (StockM>=0)
--Asegurar que la cantidad de productos, medicinas adquiridas sea mayor a 1
ALTER TABLE DETALLE_VENTA
ADD CONSTRAINT chk_CantidadP CHECK (Cantidad>=1)
ALTER TABLE DETALLE_RECETA
ADD CONSTRAINT chk_CantidadM CHECK (CantidadM>=1)
--INSERT INTOS
--TABLAS FUERTES
--INSERT INTO DUEÑO
INSERT INTO DUEÑO (DNI_C, Nombre_C, Apellido_PC, Apellido_MC, Direccion_C)
VALUES
('12345678', 'Diego', 'Veliz', 'Salinas', 'Av. Siempre Viva 123'),
('87654321', 'Cesar', 'Taboada', 'Cáceres', 'Santiago Crespo 456'),
('34567890', 'Luis', 'Hernández', 'Torres', 'Av. Principal 789'),
('23456789', 'Ana', 'García', 'Ramírez', 'Calle Secundaria 101'),
('98765432', 'Carlos', 'Ruiz', 'Fernández', 'Av. La Paz 202'),
('45678901', 'Elena', 'Morales', 'Díaz', 'Calle Esperanza 303'),
('56789012', 'Marta', 'Castro', 'Rojas', 'Av. Libertad 404'),
('67890123', 'Pedro', 'Gómez', 'Torres', 'Calle Sol 505'),
('78901234', 'Lucía', 'Mendoza', 'Pérez', 'Av. Luna 606'),
('89012345', 'Andrés', 'Rojas', 'Ramírez', 'Calle Estrella 707'),
('90123456', 'Sofía', 'Díaz', 'Fernández', 'Av. Mar 808'),
('01234567', 'Daniel', 'Suárez', 'Morales', 'Calle Cielo 909'),
('12345098', 'Juliana', 'Hernández', 'López', 'Av. Rosa 111'),
('23456109', 'Gabriel', 'Castro', 'Martínez', 'Calle Tulipán 222'),
('34567210', 'Paula', 'Pérez', 'Ramírez', 'Av. Violeta 333'),
('45678321', 'Ricardo', 'Gómez', 'Fernández', 'Calle Girasol 444'),
('56789432', 'Teresa', 'Ruiz', 'López', 'Av. Orquídea 555'),
('67890543', 'Antonio', 'Hernández', 'García', 'Calle Lirio 666'),
('78901654', 'Patricia', 'Martínez', 'Rojas', 'Av. Magnolia 777'),
('89012765', 'Anelis', 'Mitma', 'De la Cruz', 'Calle Jacaranda 888');
Select * from dueño
--INSERT INTO VETERINARIO
INSERT INTO VETERINARIO (Nombre_V, Apellido_VP, Apellido_VM, Num_Acreditacion,
DNI_V) VALUES
('Carlos', 'Fernandez', 'De la Paz', '123456', '23456789'),
('Ana', 'García', 'Gomez', '654321', '98765432'),
('Pedro', 'Gómez', 'Hernández', '112233', '34567890'),
('Lucía', 'Martínez', 'López', '223344', '12345678'),
('Julio', 'Pérez', 'Castro', '334455', '45678901'),
('Sofía', 'Díaz', 'Morales', '445566', '56789012'),
('Marta', 'Suárez', 'García', '556677', '67890123'),
('Andrés', 'Rojas', 'Torres', '667788', '78901234'),
('Paula', 'Fernández', 'Pérez', '778899', '89012345'),
('Ricardo', 'Ramírez', 'Martínez', '889900', '90123456'),
('Gabriel', 'López', 'Ruiz', '990011', '01234567'),
('Elena', 'García', 'Díaz', '101112', '12345098'),
('Antonio', 'Morales', 'Suárez', '121314', '23456109'),
('Juliana', 'Hernández', 'Rojas', '131415', '34567210'),
('Roberto', 'Gómez', 'Mendoza', '141516', '45678321'),
('Patricia', 'Castro', 'Fernández', '151617', '56789432'),
('Teresa', 'Martínez', 'García', '161718', '67890543'),
('Daniel', 'Pérez', 'Torres', '171819', '78901654'),
('Roxana', 'Excelsa', 'BellaVista', '181920', '89012765'),
('Luis', 'García', 'Morales', '192021', '90123876');
Select * from veterinario
INSERT INTO CUIDADOR (NombresC, ApellidoPC, ApellidoMC, DNIC, Fecha_Ingreso,
Sueldo) VALUES
('Luis', 'Hernández', 'Torres', '34567890', '2022-01-01', 500),
('Elena', 'Morales', 'Díaz', '87654321', '2022-02-15', 300),
('María', 'Gómez', 'Pérez', '23456789', '2022-03-20', 0),
('Carlos', 'Ramírez', 'López', '12345678', '2022-04-25', 0),
('Sofía', 'García', 'Hernández', '45678901', '2022-05-30', 1050),
('Ana', 'Suárez', 'Martínez', '56789012', '2022-06-15', 0),
('Pedro', 'Rojas', 'Fernández', '67890123', '2022-07-20', 400),
('Lucía', 'Mendoza', 'Díaz', '78901234', '2022-08-25', 300),
('Julio', 'López', 'García', '89012345', '2022-09-30', 1050),
('Paula', 'Fernández', 'Suárez', '90123456', '2022-10-05', 0),
('Gabriel', 'Cruz', 'Ramírez', '01234567', '2022-11-10', 400),
('Teresa', 'Gómez', 'Hernández', '12345098', '2022-12-15', 0),
('Antonio', 'Díaz', 'Martínez', '23456109', '2023-01-20', 500),
('Roberto', 'Ramírez', 'López', '34567210', '2023-02-25', 300),
('Patricia', 'Hernández', 'García', '45678321', '2023-03-30', 0),
('Daniel', 'Asturrizaga', 'Torres', '56789432', '2023-04-15', 300),
('Marta', 'García', 'Rojas', '67890543', '2023-05-20', 500),
('Juliana', 'Martínez', 'Mendoza', '78901654', '2023-06-25', 1050),
('Andrés', 'Pérez', 'Fernández', '89012765', '2023-07-30', 300),
('Ricardo', 'Gómez', 'Díaz', '90123876', '2023-08-05', 0);
Select * from cuidador
INSERT INTO LABORATORIO (NombreL, RUCL, DireccionL) VALUES
('LabVet', '12345678901', 'Av. Principal 101'),
('VetLab', '10987654321', 'Calle Secundaria 202'),
('BioVet', '23456789012', 'Av. San Martín 303'),
('ClinVet', '34567890123', 'Calle Bolívar 404'),
('PetLab', '45678901234', 'Av. Libertad 505'),
('VetLabPlus', '56789012345', 'Calle Esperanza 606'),
('AnimalLab', '67890123456', 'Av. Siempre Viva 707'),
('VetCare', '78901234567', 'Calle Falsa 808'),
('MedLab', '89012345678', 'Av. La Paz 909'),
('VetScience', '90123456789', 'Calle Sol 111'),
('PetScience', '01234567890', 'Av. Luna 222'),
('BioScience', '12345098765', 'Calle Estrella 333'),
('ClinScience', '23456109876', 'Av. Mar 444'),
('AnimalCare', '34567210987', 'Calle Cielo 555'),
('VetBio', '45678321098', 'Av. Rosa 666'),
('PetBio', '56789432109', 'Calle Tulipán 777'),
('MedCare', '67890543210', 'Av. Violeta 888'),
('VetCarePlus', '78901654321', 'Calle Girasol 999'),
('AnimalScience', '89012765432', 'Av. Orquídea 101'),
('PetCare', '90123876543', 'Calle Lirio 202');
Select * from laboratorio
INSERT INTO TIPO_EXAMENI (DescripciónEI, LugardeArchivoEI, Precio) VALUES
('Rayos-X', 'C:\\ArchiveroLab\\RayosX', 200.00),
('Ultrasonido', 'C:\\ArchiveroLab\\Ultrasonido', 300.00),
('Resonancia Magnética', 'C:\\ArchiveroLab\\ResonanciaMagnetica', 400.00),
('Tomografía', 'C:\\ArchiveroLab\\Tomografia', 500.00),
('Ecocardiograma', 'C:\\ArchiveroLab\\Ecocardiograma', 350.00),
('Electrocardiograma', 'C:\\ArchiveroLab\\Electrocardiograma', 150.00),
('Endoscopía', 'C:\\ArchiveroLab\\Endoscopia', 450.00),
('Fluoroscopía', 'C:\\ArchiveroLab\\Fluoroscopia', 500.00),
('Cistografía', 'C:\\ArchiveroLab\\Cistografia', 250.00),
('Mielografía', 'C:\\ArchiveroLab\\Mielografia', 400.00),
('Artrografía', 'C:\\ArchiveroLab\\Artrografia', 300.00),
('Gammagrafía', 'C:\\ArchiveroLab\\Gammagrafia', 600.00),
('Broncoscopía', 'C:\\ArchiveroLab\\Broncoscopia', 400.00),
('Colangiografía', 'C:\\ArchiveroLab\\Colangiografia', 450.00),
('Colonoscopia', 'C:\\ArchiveroLab\\Colonoscopia', 500.00),
('Urografía', 'C:\\ArchiveroLab\\Urografia', 350.00),
('Linfografía', 'C:\\ArchiveroLab\\Linfografia', 300.00),
('Ultrasonografía', 'C:\\ArchiveroLab\\Ultrasonografía', 450.00),
('Neurografía', 'C:\\ArchiveroLab\\Neurografia', 450.00),
('Venografía', 'C:\\ArchiveroLab\\Venografia', 300.00);
Select * from TIPO_EXAMENI
INSERT INTO TIPO_EXAMENl (DescripciónEL, LugardeArchivoEL, Precio) VALUES
('Hematología', 'C:\\ArchiveroLab\\Hematologia', 300.00),
('Bioquímica Sanguínea', 'C:\\ArchiveroLab\\Bioquimica', 350.00),
('Urianálisis', 'C:\\ArchiveroLab\\Urianalisis', 200.00),
('Parasitología', 'C:\\ArchiveroLab\\Parasitologia', 250.00),
('Serología', 'C:\\ArchiveroLab\\Serologia', 300.00),
('Microbiología', 'C:\\ArchiveroLab\\Microbiologia', 400.00),
('Citología', 'C:\\ArchiveroLab\\Citologia', 350.00),
('Histopatología', 'C:\\ArchiveroLab\\Histopatologia', 500.00),
('Inmunología', 'C:\\ArchiveroLab\\Inmunologia', 450.00),
('Endocrinología', 'C:\\ArchiveroLab\\Endocrinologia', 400.00),
('Coagulación', 'C:\\ArchiveroLab\\Coagulacion', 250.00),
('Toxicología', 'C:\\ArchiveroLab\\Toxicologia', 600.00),
('Genética', 'C:\\ArchiveroLab\\Genetica', 700.00),
('Electrolitos', 'C:\\ArchiveroLab\\Electrolitos', 300.00),
('Bacteriología', 'C:\\ArchiveroLab\\Bacteriologia', 350.00),
('Micología', 'C:\\ArchiveroLab\\Micologia', 400.00),
('Virología', 'C:\\ArchiveroLab\\Virologia', 450.00),
('Hormonas', 'C:\\ArchiveroLab\\Hormonas', 500.00),
('Perfil Renal', 'C:\\ArchiveroLab\\PerfilRenal', 350.00),
('Perfil Hepático', 'C:\\ArchiveroLab\\PerfilHepatico', 350.00);
Select * from TIPO_EXAMENl
INSERT INTO PRODUCTOS (PrecioP, StockP, Tipo_Producto, Descripcion) VALUES
(25.00, 200, 'Juguete', 'Pelota de goma'),
(15.50, 300, 'Comida', 'Croquetas para perro'),
(10.75, 150, 'Accesorio', 'Collar de perro'),
(20.00, 250, 'Higiene', 'Champú para gatos'),
(18.50, 180, 'Medicamento', 'Antipulgas'),
(12.75, 220, 'Accesorio', 'Correa para perro'),
(22.00, 170, 'Comida', 'Comida húmeda'),
(19.50, 190, 'Juguete', 'Rascador para gatos'),
(14.75, 210, 'Higiene', 'Arena para gatos'),
(17.00, 160, 'Medicamento', 'Desparasitante'),
(11.50, 230, 'Accesorio', 'Juguete de goma'),
(23.00, 200, 'Comida', 'Alimento premium'),
(16.50, 150, 'Higiene', 'Cepillo para gatos'),
(13.75, 220, 'Accesorio', 'Casa para perros'),
(21.00, 180, 'Comida', 'Snacks para perros'),
(20.50, 170, 'Juguete', 'Cuerda para morder'),
(15.75, 210, 'Higiene', 'Cortaúñas para gatos'),
(19.00, 160, 'Higiene', 'Spray antipulgas'),
(18.00, 230, 'Accesorio', 'Transportín'),
(22.50, 200, 'Comida', 'Catnip para gatos');
Select * from PRODUCTOS
INSERT INTO MEDICINA (DescripcionM, TipoM, StockM, PrecioUM) VALUES
('Ibuprofeno', 'Analgésico', 100, 5.50),
('Amoxicilina', 'Antibiótico', 150, 3.75),
('Paracetamol', 'Antipirético', 200, 4.00),
('Metamizol', 'Analgésico', 180, 6.25),
('Ciprofloxacina', 'Antibiótico', 130, 7.50),
('Doxiciclina', 'Antibiótico', 110, 8.00),
('Naproxeno', 'Antiinflamatorio', 90, 4.50),
('Cetirizina', 'Antialérgico', 170, 3.25),
('Omeprazol', 'Antiacido', 140, 5.00),
('Loratadina', 'Antialérgico', 160, 4.75),
('Azitromicina', 'Antibiótico', 190, 6.00),
('Levotiroxina', 'Hormonal', 80, 7.25),
('Metformina', 'Antidiabético', 150, 5.75),
('Atorvastatina', 'Hipolipemiante', 120, 8.50),
('Losartán', 'Antihipertensivo', 110, 9.00),
('Enalapril', 'Antihipertensivo', 100, 7.75),
('Claritromicina', 'Antibiótico', 140, 6.50),
('Bromazepam', 'Ansiolítico', 130, 9.25),
('Prednisona', 'Corticoide', 90, 5.25),
('Fluconazol', 'Antifúngico', 170, 4.50);
Select * from MEDICINA
INSERT INTO MASCOTA (Nombre_M, Sexo_M, Color_M, Especie_M, Raza_M, Edad_M,
Fecha_VacM, Fecha_DesM, ID_Dueño) VALUES
('Khala', 'F', 'Negro', 'Perro', 'Cruce', 3, '2023-01-10', '2023-02-10', 1),
('Raiden', 'M', 'Blanco', 'Perro', 'Jack Rusell', 2, '2023-02-15', '2023-03-15', 2),
('Max', 'M', 'Blanco', 'Perro', 'Bulldog', 5, '2023-03-20', '2023-04-20', 3),
('Luna', 'F', 'Gris', 'Gato', 'Persa', 4, '2023-04-25', '2023-05-25', 4),
('Charlie', 'M', 'Negro', 'Perro', 'Beagle', 2, '2023-05-30', '2023-06-30', 5),
('Bella', 'F', 'Blanco', 'Gato', 'Maine Coon', 1, '2023-06-05', '2023-07-05', 4),
('Rocky', 'M', 'Marrón', 'Perro', 'Boxer', 3, '2023-07-10', '2023-08-10', 7),
('Molly', 'F', 'Gris', 'Gato', 'Ragdoll', 2, '2023-08-15', '2023-09-15', 8),
('Oscar', 'M', 'Blanco', 'Perro', 'Poodle', 4, '2023-09-20', '2023-10-20', 9),
('Daisy', 'F', 'Negro', 'Gato', 'British Shorthair', 3, '2023-10-25', '2023-11-25', 10),
('Jack', 'M', 'Marrón', 'Perro', 'Golden Retriever', 5, '2023-11-30', '2023-12-30', 1),
('Chloe', 'F', 'Gris', 'Gato', 'Bengalí', 1, '2023-12-05', '2024-01-05', 7),
('Zeus', 'M', 'Blanco', 'Perro', 'Dálmata', 2, '2024-01-10', '2024-02-10', 9),
('Sophie', 'F', 'Negro', 'Gato', 'Siberiano', 4, '2024-02-15', '2024-03-15', 8),
('Toby', 'M', 'Marrón', 'Perro', 'Chihuahua', 3, '2024-03-20', '2024-04-20', 2),
('Lily', 'F', 'Gris', 'Gato', 'Abisinio', 2, '2024-04-25', '2024-05-25', 10),
('Rex', 'M', 'Negro', 'Perro', 'Rottweiler', 4, '2024-05-30', '2024-06-30', 8),
('Mia', 'F', 'Blanco', 'Gato', 'Angora', 1, '2024-06-05', '2024-07-05', 5),
('Finn', 'M', 'Marrón', 'Perro', 'Schnauzer', 2, '2024-07-10', '2024-08-10', 4),
('Ruby', 'F', 'Negro', 'Gato', 'Burmés', 3, '2024-08-15', '2024-09-15', 3);
Select * from MASCOTA
INSERT INTO BOLETA (Total_NetoC, Total_NetoV, Total_NetoSE, Total_Boleta,
Fecha_Emision, IGV, ID_Dueño, ID_MASCOTA) VALUES
(0, 0, 0, 0, '2023-01-10', 0.18, 1, 1),
(0, 0, 0, 0, '2023-02-15', 0.18, 2, 2),
(0, 0, 0, 0, '2023-03-20', 0.18, 3, 3),
(0, 0, 0, 0, '2023-04-25', 0.18, 4, 4),
(0, 0, 0, 0, '2023-05-30', 0.18, 5, 5),
(0, 0, 0, 0, '2023-06-05', 0.18, 4, 6),
(0, 0, 0, 0, '2023-07-10', 0.18, 7, 7),
(0, 0, 0, 0, '2023-08-15', 0.18, 8, 8),
(0, 0, 0, 0, '2023-09-20', 0.18, 9, 9),
(0, 0, 0, 0, '2023-10-25', 0.18, 10, 10),
(0, 0, 0, 0, '2023-11-30', 0.18, 1, 11),
(0, 0, 0, 0, '2023-12-05', 0.18, 7, 12),
(0, 0, 0, 0,'2024-01-10', 0.18, 9, 13),
(0, 0, 0, 0, '2024-02-15', 0.18, 8, 14),
(0, 0, 0, 0, '2024-03-20', 0.18, 2, 15),
(0, 0, 0, 0, '2024-04-25', 0.18, 10, 16),
(0, 0, 0, 0, '2024-05-30', 0.18, 8, 17),
(0, 0, 0, 0, '2024-06-05', 0.18, 5, 18),
(0, 0, 0, 0, '2024-07-10', 0.18, 4, 19),
(0, 0, 0, 0, '2024-08-15', 0.18, 3, 20);
Select * from BOLETA
INSERT INTO CONSULTA (Motivo_C, ID_Veterinario) VALUES
('Chequeo general', 1),
('Vacunación', 10),
('Desparasitación', 5),
('Chequeo de rutina', 9),
('Enfermedad', 5),
('Consulta por alergia', 4),
('Chequeo general', 10),
('Vacunación', 8),
('Desparasitación', 9),
('Chequeo de rutina', 10),
('Fiebre', 1),
('Consulta por alergia', 8),
('Chequeo general', 6),
('Vacunación', 2),
('Desparasitación', 7),
('Chequeo de rutina', 6),
('Enfermedad', 3),
('Consulta por alergia', 3),
('Chequeo general', 10),
('Vacunación', 4);
Select * from CONSULTA
INSERT INTO ANAMNESIS (ID_Consulta, Sintomas) VALUES
(1, 'Ninguno'),
(2, 'Ninguno'),
(3, 'Intoxicacion'),
(4, 'Ninguno'),
(5, 'Fiebre y tos'),
(6, 'Picazón'),
(6, 'Enrojecimiento'),
(7, 'Ninguno'),
(8, 'Ninguno'),
(9, 'Ninguno'),
(10, 'Ninguno'),
(11, 'Vómitos y diarrea'),
(12, 'Picazón'),
(12, 'Enrojecimiento'),
(13, 'Ninguno'),
(14, 'Ninguno'),
(15, 'Ninguno'),
(16, 'Ninguno'),
(17, 'Fiebre y tos'),
(18, 'Enrojecimiento'),
(19, 'Ninguno'),
(20, 'Ninguno');
Select * from ANAMNESIS
INSERT INTO EXAMEN_POR_IMAGEN (Tipo_ExamenI, ID_EILaboratorio, ID_EICONSULTA,
Observaciones, FechaEI, NombreEI) VALUES
(1, 1, 1, 'Sin observaciones', '2023-01-15', 'RayoX_001.pdf'),
(2, 1, 2, 'Fractura', '2023-01-20', 'Ultrasonido_001.pdf'),
(3, 2, 3, 'Sin observaciones', '2023-02-01', 'RMN_001.pdf'),
(4, 2, 4, 'Sin observaciones', '2023-02-05', 'TM_001.pdf'),
(5, 3, 5, 'Sin observaciones', '2023-02-10', 'Eco_001.pdf'),
(6, 3, 6, 'Sin observaciones', '2023-02-15', 'ECG_001.pdf'),
(7, 4, 7, 'Gastritis', '2023-02-20', 'Endoscopia_001.pdf'),
(8, 4, 8, 'Sin observaciones', '2023-02-25', 'Fluoroscopia_001.pdf'),
(9, 5, 9, 'Cálculo', '2023-03-01', 'Cistografia_001.pdf'),
(10, 5, 10, 'Sin observaciones', '2023-03-05', 'Mielografia_001.pdf'),
(9, 6, 9, 'Sin observaciones', '2023-03-10', 'Inmunologia_002.pdf'),
(5, 6, 8, 'Sin observaciones', '2023-03-15', 'Eco_002.pdf'),
(4, 7, 7, 'Sin observaciones', '2023-03-20', 'TM_002.pdf'),
(3, 7, 5, 'Sin observaciones', '2023-03-25', 'RMN_002.pdf'),
(2, 8, 4, 'Fractura', '2023-03-30', 'Ultrasonido_002.pdf'),
(1, 8, 10, 'Sin observaciones', '2023-04-01', 'RayoX_002.pdf'),
(6, 9, 3, 'Sin observaciones', '2023-04-05', 'ECG_002.pdf'),
(7, 9, 2, 'Obstrucción Tubárica', '2023-04-10', 'Endoscopia_002.pdf'),
(8, 10, 1, 'Sin observaciones', '2023-04-15', 'Fluoroscopia_002.pdf'),
(10, 10, 4, 'Sin observaciones', '2023-04-20', 'Mielografia_002.pdf');
Select * from RECETA
INSERT INTO EXAMEN_POR_LABORATORIO (Tipo_ExamenL, ID_ELaboratorio,
ID_ELCONSULTA, Observaciones, FechaEL, NombreEL) VALUES
(1, 1, 1, 'Sin observaciones', '2023-01-10', 'Hematologia_001.pdf'),
(2, 1, 2, 'Leucocitos bajos', '2023-01-15', 'Bioquimica_001.pdf'),
(3, 2, 3, 'Sin observaciones', '2023-01-20', 'Urianalisis_001.pdf'),
(4, 2, 4, 'Sin observaciones', '2023-01-25', 'Parasitologia_001.pdf'),
(5, 3, 5, 'Positivo', '2023-01-30', 'Serologia_001.pdf'),
(6, 3, 6, 'Infeccion gastrica', '2023-02-05', 'Microbiologia_001.pdf'),
(7, 4, 7, 'Sin observaciones', '2023-02-10', 'Citologia_001.pdf'),
(8, 4, 8, 'Falta nutrientes', '2023-02-15', 'Histopatologia_001.pdf'),
(9, 5, 9, 'Negativo', '2023-02-20', 'Inmunologia_001.pdf'),
(10, 5, 10, 'Deficiencia', '2023-02-25', 'Endocrinologia_001.pdf'),
(9, 6, 2, 'Sin observaciones', '2023-03-01', 'Inmunologia_002.pdf'),
(7, 6, 3, 'Cromosomas irregulares', '2023-03-05', 'Citologia_002.pdf'),
(6, 7, 4, 'Sin observaciones', '2023-03-10', 'Microbiologia_002.pdf'),
(5, 7, 5, 'Negativo', '2023-03-15', 'Serologia_002.pdf'),
(8, 8, 6, 'Sin observaciones', '2023-03-20', 'Histopatologia_002.pdf'),
(4, 8, 7, 'Parasito intestinal', '2023-03-25', 'Parasitologia_002.pdf'),
(3, 9, 8, 'Urea Alta', '2023-03-30', 'Urianalisis_002.pdf'),
(2, 9, 9, 'Sin observaciones', '2023-04-01', 'Bioquimica_002.pdf'),
(10, 10, 10, 'Sin observaciones', '2023-04-05', 'Endocrinologia_002.pdf'),
(1, 10, 1, 'Globulos rojos bajos', '2023-04-10', 'Hematologia_002.pdf');
Select * from EXAMEN_POR_LABORATORIO
INSERT INTO RECETA (DIAGNOSTICO, ID_CONSULTA) VALUES
('Saludable', 1),
('Necesita vacuna', 2),
('Desparasitación necesaria', 3),
('Saludable', 4),
('Infección respiratoria', 5),
('Alergia a alimentos', 6),
('Saludable', 7),
('Necesita vacuna', 8),
('Desparasitación necesaria', 9),
('Saludable', 10),
('Infección gastrointestinal', 11),
('Alergia a picaduras', 12),
('Saludable', 13),
('Necesita vacuna', 14),
('Desparasitación necesaria', 15),
('Saludable', 16),
('Infección respiratoria', 17),
('Alergia a comida', 18),
('Saludable', 19),
('Necesita vacuna', 20);
Select * from RECETA
INSERT INTO SERVICIO_ESTETICO (TipoSE, Obs, ID_Cuidador) VALUES
('Corte de pelo', 'Ninguna', 1),
('Baño', 'Usar champú especial', 2),
('Corte de uñas', 'Ninguna', 3),
('Limpieza de oídos', 'Cera abundante', 4),
('Cepillado', 'Ninguna', 5),
('Corte de pelo', 'Ninguna', 6),
('Baño', 'Usar champú especial', 7),
('Corte de uñas', 'Ninguna', 8),
('Limpieza de oídos', 'Ninguna', 9),
('Cepillado', 'Ninguna', 5),
('Corte de pelo', 'Ninguna', 4),
('Baño', 'Usar champú especial', 3),
('Corte de uñas', 'Ninguna', 2),
('Limpieza de oídos', 'Ninguna', 1),
('Cepillado', 'Ninguna', 6),
('Corte de pelo', 'Pelo áspero', 7),
('Baño', 'Usar champú especial', 8),
('Corte de uñas', 'Ninguna', 9),
('Limpieza de oídos', 'Cuidado con infecciones', 8),
('Cepillado', 'Ninguna', 10);
Select * from RECETA
--Relaciones
INSERT INTO DETALLE_CONSULTA (ID_Consulta, ID_BOLETA, TOTAL_DETALLEC) VALUES
(1, 1, 0),
(2, 2, 0),
(3, 3, 0),
(4, 4, 0),
(5, 5, 0),
(6, 6, 0),
(7, 7, 0),
(8, 8, 0),
(9, 9, 0),
(10, 10, 0),
(11, 11, 0),
(12, 12, 0),
(13, 13, 0),
(14, 14, 0),
(15, 15, 0),
(16, 16, 0),
(17, 17, 0),
(18, 18, 0),
(19, 19, 0),
(20, 20, 0);
Select * from DETALLE_RECETA
INSERT INTO DETALLE_SE (ID_SE, ID_BOLETA, TOTAL_DETALLESE) VALUES
(1, 1, 0),
(2, 2, 0),
(3, 3, 0),
(4, 4, 0),
(5, 5, 0),
(6, 6, 0),
(7, 7, 0),
(8, 8, 0),
(9, 9, 0),
(10, 10, 0),
(11, 11, 0),
(12, 12, 0),
(13, 13, 0),
(14, 14, 0),
(15, 15, 0),
(16, 16, 0),
(17, 17, 0),
(18, 18, 0),
(19, 19, 0),
(20, 20, 0);
INSERT INTO DETALLE_VENTA (ID_PRODUCTO, ID_BOLETA, CANTIDAD, TOTAL) VALUES
(1, 1, 2, 0),
(2, 2, 3, 0),
(3, 3, 1, 0),
(4, 4, 4, 0),
(5, 5, 2, 0),
(6, 6, 3, 0),
(7, 7, 1, 0),
(8, 8, 4, 0),
(9, 9, 2, 0),
(10, 10, 3, 0),
(11, 11, 1, 0),
(12, 12, 4, 0),
(13, 13, 2, 0),
(14, 14, 3, 0),
(15, 15, 1, 0),
(16, 16, 4, 0),
(17, 17, 2, 0),
(18, 18, 3, 0),
(19, 19, 1, 0),
(20, 20, 4, 0);
INSERT INTO DETALLE_RECETA (ID_MEDICINA, ID_RECETA, CANTIDADM, TOTAL) VALUES
(1, 1, 2,0),
(2, 2, 3, 0),
(3, 3, 1, 0),
(4, 4, 4, 0),
(5, 5, 2, 0),
(6, 6, 3, 0),
(7, 7, 1, 0),
(8, 8, 4, 0),
(9, 9, 2, 0),
(10, 10, 3, 0),
(11, 11, 1, 0),
(12, 12, 4, 0),
(13, 13, 2, 0),
(14, 14, 3, 0),
(15, 15, 1, 0),
(16, 16, 4, 0),
(17, 17, 2, 0),
(18, 18, 3, 0),
(19, 19, 1, 0),
(20, 20, 4, 0);
--Updates y eliminaciones
DELETE FROM Dueño WHERE ID_Dueño BETWEEN 11 AND 20;
UPDATE Dueño Set Direccion_C = 'Santiago Crespo 813' WHERE ID_Dueño=1;
UPDATE Dueño Set Direccion_C = 'Santiago Crespo 811' WHERE ID_Dueño=2;
UPDATE Dueño Set Direccion_C = 'Santiago Crespo 812' WHERE ID_Dueño=3;
UPDATE Dueño Set Direccion_C = 'Santiago Crespo 809' WHERE ID_Dueño=4;
UPDATE Dueño Set Direccion_C = 'Santiago Crespo 820' WHERE ID_Dueño=5;
UPDATE Dueño Set Direccion_C = 'Augusto Durand 812' WHERE ID_Dueño=6;
UPDATE Dueño Set Direccion_C = 'Augusto Durand 832' WHERE ID_Dueño=7;
UPDATE Dueño Set Direccion_C = 'Augusto Durand 825' WHERE ID_Dueño=8;
UPDATE Dueño Set Direccion_C = 'Augusto Durand 832' WHERE ID_Dueño=9;
UPDATE Dueño Set Direccion_C = 'Augusto Durand 813' WHERE ID_Dueño=10;
Select * From DUEÑO
DELETE FROM VETERINARIO WHERE ID_Veterinario BETWEEN 11 AND 20;
UPDATE VETERINARIO Set Num_Acreditacion = '548723915627083' WHERE
ID_Veterinario=1;
UPDATE VETERINARIO Set Num_Acreditacion = '173684290517462' WHERE
ID_Veterinario=2;
UPDATE VETERINARIO Set Num_Acreditacion = '965421378405296' WHERE
ID_Veterinario=3;
UPDATE VETERINARIO Set Num_Acreditacion = '742985163204879' WHERE
ID_Veterinario=4;
UPDATE VETERINARIO Set Num_Acreditacion = '328174509637512' WHERE
ID_Veterinario=5;
UPDATE VETERINARIO Set Num_Acreditacion = '894527631940281' WHERE
ID_Veterinario=6;
UPDATE VETERINARIO Set Num_Acreditacion = '250936481752043' WHERE
ID_Veterinario=7;
UPDATE VETERINARIO Set Num_Acreditacion = '671529483216054' WHERE
ID_Veterinario=8;
UPDATE VETERINARIO Set Num_Acreditacion = '309847561428790' WHERE
ID_Veterinario=9;
UPDATE VETERINARIO Set Num_Acreditacion = '784619032587421' WHERE
ID_Veterinario=10;
Select * From VETERINARIO
DELETE FROM CUIDADOR WHERE ID_Cuidador BETWEEN 11 AND 20;
UPDATE CUIDADOR Set Sueldo = 350 WHERE ID_Cuidador=1;
UPDATE CUIDADOR Set Sueldo = 0 WHERE ID_Cuidador=2;
UPDATE CUIDADOR Set Sueldo = 400 WHERE ID_Cuidador=3;
UPDATE CUIDADOR Set Sueldo = 0 WHERE ID_Cuidador=4;
UPDATE CUIDADOR Set Sueldo = 1050 WHERE ID_Cuidador=5;
UPDATE CUIDADOR Set Sueldo = 1050 WHERE ID_Cuidador=6;
UPDATE CUIDADOR Set Sueldo = 0 WHERE ID_Cuidador=7;
UPDATE CUIDADOR Set Sueldo = 200 WHERE ID_Cuidador=8;
UPDATE CUIDADOR Set Sueldo = 300 WHERE ID_Cuidador=9;
UPDATE CUIDADOR Set Sueldo = 0 WHERE ID_Cuidador=10;
Select * From CUIDADOR
DELETE FROM LABORATORIO WHERE ID_Laboratorio BETWEEN 11 AND 20;
UPDATE LABORATORIO Set RUCL = '10123456789' WHERE ID_Laboratorio=1;
UPDATE LABORATORIO Set RUCL = '10234567891' WHERE ID_Laboratorio=2;
UPDATE LABORATORIO Set RUCL = '10345678912' WHERE ID_Laboratorio=3;
UPDATE LABORATORIO Set RUCL = '10456789123' WHERE ID_Laboratorio=4;
UPDATE LABORATORIO Set RUCL = '10567891234' WHERE ID_Laboratorio=5;
UPDATE LABORATORIO Set RUCL = '10678912345' WHERE ID_Laboratorio=6;
UPDATE LABORATORIO Set RUCL = '10789123456' WHERE ID_Laboratorio=7;
UPDATE LABORATORIO Set RUCL = '10891234567' WHERE ID_Laboratorio=8;
UPDATE LABORATORIO Set RUCL = '10912345678' WHERE ID_Laboratorio=9;
UPDATE LABORATORIO Set RUCL = '11023456789' WHERE ID_Laboratorio=10;
Select * From TIPO_EXAMENI
DELETE FROM TIPO_EXAMENI WHERE ID_TipoExamenI BETWEEN 11 AND 20;
UPDATE TIPO_EXAMENI Set LugardeArchivoEI =
'C:\\ArchiveroLab\\Tipo_ExamenI\\RayosX' WHERE ID_TipoExamenI =1
UPDATE TIPO_EXAMENI Set LugardeArchivoEI =
'C:\\ArchiveroLab\\Tipo_ExamenI\\Ultrasonido' WHERE ID_TipoExamenI =2
UPDATE TIPO_EXAMENI Set LugardeArchivoEI =
'C:\\ArchiveroLab\\Tipo_ExamenI\\ResonanciaMag' WHERE ID_TipoExamenI =3
UPDATE TIPO_EXAMENI Set LugardeArchivoEI =
'C:\\ArchiveroLab\\Tipo_ExamenI\\Tomografia' WHERE ID_TipoExamenI =4
UPDATE TIPO_EXAMENI Set LugardeArchivoEI =
'C:\\ArchiveroLab\\Tipo_ExamenI\\Ecocardiograma' WHERE ID_TipoExamenI =5
UPDATE TIPO_EXAMENI Set LugardeArchivoEI =
'C:\\ArchiveroLab\\Tipo_ExamenI\\Electrocardiograma' WHERE ID_TipoExamenI =6
UPDATE TIPO_EXAMENI Set LugardeArchivoEI =
'C:\\ArchiveroLab\\Tipo_ExamenI\\Endoscopia' WHERE ID_TipoExamenI =7
UPDATE TIPO_EXAMENI Set LugardeArchivoEI =
'C:\\ArchiveroLab\\Tipo_ExamenI\\Fluoroscopia' WHERE ID_TipoExamenI =8
UPDATE TIPO_EXAMENI Set LugardeArchivoEI =
'C:\\ArchiveroLab\\Tipo_ExamenI\\Cistografia' WHERE ID_TipoExamenI =9
UPDATE TIPO_EXAMENI Set LugardeArchivoEI =
'C:\\ArchiveroLab\\Tipo_ExamenI\\Mielografia' WHERE ID_TipoExamenI =10
Select * From TIPO_EXAMENL
DELETE FROM TIPO_EXAMENL WHERE ID_TipoExamenL BETWEEN 11 AND 20;
UPDATE TIPO_EXAMENL Set LugardeArchivoEL =
'C:\\ArchiveroLab\\Tipo_ExamenL\\Hematologia' WHERE ID_TipoExamenL =1
UPDATE TIPO_EXAMENL Set LugardeArchivoEL =
'C:\\ArchiveroLab\\Tipo_ExamenL\\Bioquimica' WHERE ID_TipoExamenL =2
UPDATE TIPO_EXAMENL Set LugardeArchivoEL =
'C:\\ArchiveroLab\\Tipo_ExamenL\\Urianalisis' WHERE ID_TipoExamenL =3
UPDATE TIPO_EXAMENL Set LugardeArchivoEL =
'C:\\ArchiveroLab\\Tipo_ExamenL\\Parasitologia' WHERE ID_TipoExamenL =4
UPDATE TIPO_EXAMENL Set LugardeArchivoEL =
'C:\\ArchiveroLab\\Tipo_ExamenL\\Serologia' WHERE ID_TipoExamenL =5
UPDATE TIPO_EXAMENL Set LugardeArchivoEL =
'C:\\ArchiveroLab\\Tipo_ExamenL\\Microbiologia' WHERE ID_TipoExamenL =6
UPDATE TIPO_EXAMENL Set LugardeArchivoEL =
'C:\\ArchiveroLab\\Tipo_ExamenL\\Citologia' WHERE ID_TipoExamenL =7
UPDATE TIPO_EXAMENL Set LugardeArchivoEL =
'C:\\ArchiveroLab\\Tipo_ExamenL\\Histopatologia' WHERE ID_TipoExamenL =8
UPDATE TIPO_EXAMENL Set LugardeArchivoEL =
'C:\\ArchiveroLab\\Tipo_ExamenL\\Inmunologia' WHERE ID_TipoExamenL =9
UPDATE TIPO_EXAMENL Set LugardeArchivoEL =
'C:\\ArchiveroLab\\Tipo_ExamenL\\Endocrinologia' WHERE ID_TipoExamenL =10
DELETE FROM MEDICINA WHERE ID_Medicina BETWEEN 11 AND 20;
UPDATE MEDICINA Set StockM = StockM -100
DELETE FROM PRODUCTOS WHERE ID_Producto BETWEEN 11 AND 20;
UPDATE PRODUCTOS Set StockP = StockP -100
Select * From DETALLE_CONSULTA
UPDATE PRODUCTOS Set StockP = StockP -100
DELETE FROM DETALLE_RECETA WHERE ID_DRECETA BETWEEN 11 AND 20;
UPDATE PRODUCTOS Set StockP = StockP + 50
DELETE FROM DETALLE_RECETA WHERE ID_DRECETA BETWEEN 11 AND 20;
UPDATE DETALLE_RECETA SET TOTAL = CANTIDADM * m.PrecioUM
FROM MEDICINA m INNER JOIN DETALLE_RECETA dr
ON (m.ID_Medicina=dr.ID_MEDICINA)
DELETE FROM DETALLE_VENTA WHERE ID_DETALLEV BETWEEN 11 AND 20;
UPDATE DETALLE_VENTA SET TOTAL = CANTIDAD * p.PrecioP
FROM PRODUCTOS p INNER JOIN DETALLE_VENTA dV
ON (p.ID_Producto=dV.ID_PRODUCTO)
--Creacion de vistas--
--1--
CREATE VIEW VistaDueñosMascotas AS
SELECT
 d.ID_Dueño,
 d.Nombre_C + ' ' +
 d.Apellido_PC + ' ' + d.Apellido_MC AS NombreCompletoDueño, -- Concatenar
ApellidoPaterno y ApellidoMaterno
 m.ID_Mascota,
 m.Nombre_M AS NombreMascota,
 m.Sexo_M AS SexoMascota,
 m.Color_M AS ColorMascota,
 m.Especie_M AS EspecieMascota,
 m.Raza_M AS RazaMascota,
 m.Edad_M AS EdadMascota
FROM
 [TRABAJOFINALGEREI].[dbo].[DUEÑO] d
JOIN
 [TRABAJOFINALGEREI].[dbo].[MASCOTA] m ON d.ID_Dueño = m.ID_Dueño;
Select * From VistaDueñosMascotas
--2--
CREATE VIEW VistaHistorialCitasMascotas AS
SELECT
 m.ID_Mascota,
 m.Nombre_M AS NombreMascota,
 v.Nombre_V + ' ' + v.Apellido_VP + ' ' + v.Apellido_VM AS NombreCompletoVeterinario,
 c.Motivo_C AS MotivoConsulta,
 b.Fecha_Emision AS Fecha
FROM
 [TRABAJOFINALGEREI].[dbo].[MASCOTA] m
JOIN
 [TRABAJOFINALGEREI].[dbo].[DUEÑO] d ON m.ID_Dueño = d.ID_Dueño
JOIN
 [TRABAJOFINALGEREI].[dbo].[BOLETA] b ON d.ID_Dueño = b.ID_Dueño AND
m.ID_Mascota = b.ID_Mascota
JOIN
 [TRABAJOFINALGEREI].[dbo].[DETALLE_CONSULTA] dc ON b.ID_Boleta = dc.ID_Boleta
JOIN
 [TRABAJOFINALGEREI].[dbo].[CONSULTA] c ON dc.ID_Consulta = c.ID_Consulta
JOIN
 [TRABAJOFINALGEREI].[dbo].[VETERINARIO] v ON c.ID_Veterinario = v.ID_Veterinario;
Select * From VistaHistorialCitasMascotas
--3--
CREATE VIEW VistaConsultasProgramadasVeterinario AS
SELECT
 v.ID_Veterinario,
 v.Nombre_V + ' ' + v.Apellido_VP + ' ' + v.Apellido_VM AS NombreCompletoVeterinario, --
Concatenar Nombre, ApellidoPaterno y ApellidoMaterno del Veterinario
 c.ID_Consulta,
 c.Motivo_C AS MotivoConsulta,
 m.ID_Mascota,
 m.Nombre_M AS NombreMascota,
 d.ID_Dueño,
 d.Nombre_C + ' ' + d.Apellido_PC + ' ' + d.Apellido_MC AS NombreCompletoDueño, --
Concatenar Nombre, ApellidoPaterno y ApellidoMaterno del Dueño
 b.Fecha_Emision AS FechaCita
FROM
 [TRABAJOFINALGEREI].[dbo].[CONSULTA] c
JOIN
 [TRABAJOFINALGEREI].[dbo].[VETERINARIO] v ON c.ID_Veterinario = v.ID_Veterinario
JOIN
 [TRABAJOFINALGEREI].[dbo].[DETALLE_CONSULTA] dc ON c.ID_Consulta =
dc.ID_Consulta
JOIN
 [TRABAJOFINALGEREI].[dbo].[BOLETA] b ON dc.ID_Boleta = b.ID_Boleta
JOIN
 [TRABAJOFINALGEREI].[dbo].[MASCOTA] m ON b.ID_Mascota = m.ID_Mascota
JOIN
 [TRABAJOFINALGEREI].[dbo].[DUEÑO] d ON m.ID_Dueño = d.ID_Dueño
WHERE
 b.Fecha_Emision >= GETDATE(); -- Filtrar por citas futuras o actuales
--4--
CREATE VIEW VistaStockProductosMedicinas AS
SELECT
 p.ID_Producto,
 p.Descripcion AS DescripcionProducto,
 p.StockP,
 p.PrecioP,
 m.ID_Medicina,
 m.DescripcionM AS DescripcionMedicina,
 m.StockM,
 m.PrecioUM
FROM
 [TRABAJOFINALGEREI].[dbo].[PRODUCTOS] p
FULL OUTER JOIN
 [TRABAJOFINALGEREI].[dbo].[MEDICINA] m ON p.ID_Producto = m.ID_Medicina;
--5--
CREATE VIEW VistaExamenesConsultaMascota AS
SELECT
 c.ID_Consulta,
 el.Tipo_ExamenL AS TipoExamenLaboratorio,
 el.FechaEL AS FechaExamenLaboratorio,
 el.NombreEL AS NombreExamenLaboratorio,
el.Observaciones AS ObservacionesL,
 ei.Tipo_ExamenI AS TipoExamenImagen,
 ei.FechaEI AS FechaExamenImagen,
 ei.NombreEI AS NombreExamenImagen,
 ei.Observaciones AS ObservacionesI,
 m.ID_Mascota,
 m.Nombre_M AS NombreMascota
FROM
 [TRABAJOFINALGEREI].[dbo].[CONSULTA] c
LEFT JOIN
 [TRABAJOFINALGEREI].[dbo].[EXAMEN_POR_LABORATORIO] el ON c.ID_Consulta =
el.ID_ELCONSULTA
LEFT JOIN
 [TRABAJOFINALGEREI].[dbo].[EXAMEN_POR_IMAGEN] ei ON c.ID_Consulta =
ei.ID_EICONSULTA
JOIN
 [TRABAJOFINALGEREI].[dbo].[DETALLE_CONSULTA] dc ON c.ID_Consulta =
dc.ID_Consulta
JOIN
 [TRABAJOFINALGEREI].[dbo].[BOLETA] b ON dc.ID_Boleta = b.ID_Boleta
JOIN
 [TRABAJOFINALGEREI].[dbo].[MASCOTA] m ON b.ID_Mascota = m.ID_Mascota;
--Proceures
--FUNCIONES
--1--
CREATE FUNCTION SumarDetalleReceta(@ID_Receta INT)
RETURNS FLOAT
AS
BEGIN
 DECLARE @Total FLOAT;
 SELECT @Total = SUM(dr.CANTIDADM * m.PrecioUM)
 FROM DETALLE_RECETA dr
 INNER JOIN MEDICINA m
 ON m.ID_Medicina = dr.ID_MEDICINA
 WHERE dr.ID_RECETA = @ID_Receta;

 RETURN ISNULL(@Total, 0);
END;
--2--
CREATE FUNCTION SumarDetalleVenta(@ID_V INT)
RETURNS FLOAT
AS
BEGIN
 DECLARE @Total FLOAT;
 SELECT @Total = SUM(dv.CANTIDAD * p.PrecioP)
 FROM DETALLE_VENTA dv
 INNER JOIN PRODUCTOS p
 ON p.ID_Producto= dv.ID_PRODUCTO
 WHERE dv.ID_DETALLEV = @ID_V;

 RETURN ISNULL(@Total, 0);
END;
--3--
CREATE FUNCTION SumarDetalleConsulta(@ID_DetalleConsulta INT)
RETURNS FLOAT
AS
BEGIN
 DECLARE @Total FLOAT;
 DECLARE @ID_Consulta INT;
 -- Obtener el ID_Consulta a partir del ID_DetalleConsulta
 SELECT @ID_Consulta = ID_Consulta
 FROM DETALLE_CONSULTA
 WHERE ID_DetalleConsulta = @ID_DetalleConsulta;
 -- Calcular el total
 SELECT @Total = 30 +
 ISNULL(SUM(ei.Total_ExamenI), 0) +
 ISNULL(SUM(el.Total_ExamenL), 0) +
 ISNULL(SUM(dr.Total_Receta), 0)
 FROM CONSULTA c
 INNER JOIN (
 SELECT ID_EICONSULTA, SUM(teI.Precio) AS Total_ExamenI
 FROM EXAMEN_POR_IMAGEN ei
 INNER JOIN TIPO_EXAMENI teI ON ei.Tipo_ExamenI = teI.ID_TipoExamenI
 WHERE ei.ID_EICONSULTA = @ID_Consulta
 GROUP BY ei.ID_EICONSULTA
 ) ei ON c.ID_Consulta = ei.ID_EICONSULTA
 INNER JOIN (
 SELECT ID_ELCONSULTA, SUM(teL.Precio) AS Total_ExamenL
 FROM EXAMEN_POR_LABORATORIO el
 INNER JOIN TIPO_EXAMENL teL ON el.Tipo_ExamenL = teL.ID_TipoExamenL
 WHERE el.ID_ELCONSULTA = @ID_Consulta
 GROUP BY el.ID_ELCONSULTA
 ) el ON c.ID_Consulta = el.ID_ELCONSULTA
 INNER JOIN (
 SELECT r.ID_Consulta, SUM(dr.TOTAL) AS Total_Receta
 FROM RECETA r
 INNER JOIN DETALLE_RECETA dr ON r.ID_RECETA = dr.ID_RECETA
 WHERE r.ID_Consulta = @ID_Consulta
 GROUP BY r.ID_Consulta
 ) dr ON c.ID_Consulta = dr.ID_Consulta
 WHERE c.ID_Consulta = @ID_Consulta;
 RETURN ISNULL(@Total, 0);
END;
--4--
CREATE FUNCTION SumarTotalBoleta(@ID_Boleta INT)
RETURNS FLOAT
AS
BEGIN
 DECLARE @Total FLOAT;
 SELECT @Total =
 ISNULL(SUM(dc.TOTAL_DETALLEC), 0) +
 ISNULL(SUM(dv.TOTAL), 0) +
 ISNULL(SUM(ds.TOTAL_DETALLESE), 0)
 FROM BOLETA b
 INNER JOIN DETALLE_CONSULTA dc ON b.ID_Boleta = dc.ID_BOLETA
 INNER JOIN DETALLE_VENTA dv ON b.ID_Boleta = dv.ID_BOLETA
 INNER JOIN DETALLE_SE ds ON b.ID_Boleta = ds.ID_BOLETA
 WHERE b.ID_Boleta = @ID_Boleta;
 RETURN ISNULL(@Total, 0);
END;
--Triggers--
--1--
CREATE TRIGGER ActualizarTotalDetalleReceta
ON DETALLE_RECETA
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
 DECLARE @ID_DR INT;
 DECLARE @Total FLOAT;
 -- Obtener los IDs de los detalles afectados
 DECLARE Cursor1 CURSOR FOR
 SELECT DISTINCT ID_DRECETA
 FROM INSERTED
 UNION
 SELECT DISTINCT ID_DRECETA
 FROM DELETED;
 OPEN Cursor1;
 FETCH NEXT FROM Cursor1 INTO @ID_DR
 WHILE @@FETCH_STATUS = 0
 BEGIN
 -- Llamar a la función para calcular el total
 SET @Total = dbo.SumarDetalleConsulta(@ID_DR);
 -- Actualizar el total en la tabla detalleventas
 UPDATE DETALLE_CONSULTA
 SET TOTAL_DETALLEC = @Total
 WHERE ID_DetalleConsulta= @ID_DR;
 FETCH NEXT FROM Cursor1 INTO @ID_DR;
 END;
 CLOSE Cursor1;
 DEALLOCATE Cursor1;
END;
--2--
CREATE TRIGGER ActualizarTotalDetalleVenta
ON DETALLE_VENTA
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
 DECLARE @ID_DV INT;
 DECLARE @Total FLOAT;
 -- Obtener los IDs de los detalles afectados
 DECLARE Cursor1 CURSOR FOR
 SELECT DISTINCT ID_DETALLEV
 FROM INSERTED
 UNION
 SELECT DISTINCT ID_DETALLEV
 FROM DELETED;
 OPEN Cursor1;
 FETCH NEXT FROM Cursor1 INTO @ID_DV;
 WHILE @@FETCH_STATUS = 0
 BEGIN
 -- Llamar a la función para calcular el total
 SET @Total = dbo.SumarDetalleVenta(@ID_DV);
 -- Actualizar el total en la tabla detalleventas
 UPDATE DETALLE_VENTA
 SET TOTAL = @Total
 WHERE ID_DETALLEV = @ID_DV;
 FETCH NEXT FROM Cursor1 INTO @ID_DV;
 END;
 CLOSE Cursor1;
 DEALLOCATE Cursor1;
END;
--3--
CREATE TRIGGER ActualizarTotalDetalleConsulta
ON Detalle_Consulta
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
 DECLARE @ID_DC INT;
 DECLARE @Total FLOAT;
 -- Obtener los IDs de los detalles DE CONSULTA afectados
 DECLARE Cursor1 CURSOR FOR
 SELECT DISTINCT ID_DetalleConsulta
 FROM INSERTED
 UNION
 SELECT DISTINCT ID_DetalleConsulta
 FROM DELETED;
 OPEN Cursor1;
 FETCH NEXT FROM Cursor1 INTO @ID_DC;
 WHILE @@FETCH_STATUS = 0
 BEGIN
 -- Llamar a la función para calcular el total
 SET @Total = dbo.SumarDetalleConsulta(@ID_DC);
 -- Actualizar el total en la tabla detalleconsulta
 UPDATE DETALLE_CONSULTA
 SET TOTAL_DETALLEC = @Total
 WHERE ID_DetalleConsulta = @ID_DC;
 FETCH NEXT FROM Cursor1 INTO @ID_DC;
 END;
 CLOSE Cursor1;
 DEALLOCATE Cursor1;
END;
--4--
CREATE TRIGGER ActualizarBoleta
ON BOLETA
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
 DECLARE @ID_B INT;
 DECLARE @TotalNETO FLOAT;
 -- Obtener los IDs de los detalles DE CONSULTA afectados
 DECLARE Cursor1 CURSOR FOR
 SELECT DISTINCT ID_Boleta
 FROM INSERTED
 UNION
 SELECT DISTINCT ID_Boleta
 FROM DELETED;
 OPEN Cursor1;
 FETCH NEXT FROM Cursor1 INTO @ID_B;
 WHILE @@FETCH_STATUS = 0
 BEGIN
 -- Llamar a la función para calcular el total de boleta
 SET @TotalNETO = dbo.SumarTotalBoleta(@ID_b);
 -- Actualizar el total en la tabla detalleconsulta
 UPDATE BOLETA
SET Total_NetoSE = @TotalNETO, Total_Boleta = @TotalNETO +
(@TotalNETO*0.18)
 WHERE ID_Boleta = @ID_B;
 FETCH NEXT FROM Cursor1 INTO @ID_B;
 END;
 CLOSE Cursor1;
 DEALLOCATE Cursor1;
END;
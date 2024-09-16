CREATE DATABASE dsrp_prestamos_financieros;
GO

USE dsrp_prestamos_financieros;
GO

CREATE TABLE personas_naturales (
id INT PRIMARY KEY IDENTITY (1,1),
numero_documento VARCHAR(15) UNIQUE NOT NULL,
nombres VARCHAR(255) NOT NULL,
apellido_paterno VARCHAR(255) NOT NULL,
apellido_materno VARCHAR(255) NOT NULL,
direccion NVARCHAR(1000) NOT NULL,
celular VARCHAR(15) NOT NULL,
email VARCHAR(255) NOT NULL
)


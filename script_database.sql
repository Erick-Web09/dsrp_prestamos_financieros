CREATE DATABASE dsrp_prestamos_financieros;
GO

USE dsrp_prestamos_financieros;
GO

--Crear personas naturales
CREATE TABLE personas_naturales (
id INT PRIMARY KEY IDENTITY (1,1),
numero_documento VARCHAR(15) UNIQUE NOT NULL,
nombres VARCHAR(255) NOT NULL,
apellido_paterno VARCHAR(255) NOT NULL,
apellido_materno VARCHAR(255) NOT NULL,
direccion NVARCHAR(1000) NOT NULL,
celular VARCHAR(15) NOT NULL,
email VARCHAR(255) NOT NULL
);
GO

--Crear personas Juridicas
CREATE TABLE personas_juridicas (
id INT PRIMARY KEY IDENTITY (1,1),
numero_documento VARCHAR(20) UNIQUE NOT NULL,
razon_social VARCHAR(255) NOT NULL,
domicilio_fiscal VARCHAR(1000) NOT NULL,
telefono VARCHAR(15) NOT NULL,
email VARCHAR(255) NOT NULL
);
GO

--Clientes
CREATE TABLE clientes (
id INT PRIMARY KEY IDENTITY (1,1),
persona_id INT NOT NULL,
tipo_clienye VARCHAR(100) NOT NULL,
fecha_registro DATETIME DEFAULT GETDATE() NOT NULL --Rellena automáticamente la columna con la fecha y hora actuales si no se proporciona un valor al insertar un registro.
);
GO

--Tipos prestamo
CREATE TABLE tipos_prestamos (
id INT PRIMARY KEY IDENTITY (1,1),
nombre VARCHAR(155) UNIQUE NOT NULL,
estado BIT NOT NULL,
descripción VARCHAR (500)
);
GO

EXEC sp_help clientes; --Función para ver el Detalle de la tabla creada

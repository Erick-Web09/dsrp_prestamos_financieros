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


--Sucursales
CREATE TABLE sucursales (
id INT PRIMARY KEY IDENTITY (1,1),
nombre VARCHAR(255) UNIQUE NOT NULL,
telefono VARCHAR(20) NOT NULL,
direccion NVARCHAR(500) NOT NULL,
gerente_id INT
);
GO

--Metodos de pago
CREATE TABLE metodos_pago (
id INT PRIMARY KEY IDENTITY (1,1),
nombre VARCHAR(255) UNIQUE NOT NULL,
descripcion VARCHAR (500) NOT NULL,
estado BIT NOT NULL
);
GO

--Empleados
CREATE TABLE empleados (
id INT PRIMARY KEY IDENTITY (1,1),
persona_id INT NOT NULL,
sucursal_id INT NOT NULL,
supervisor_id INT NULL,
fecha_ingreso DATE NOT NULL,
CONSTRAINT fk_persona_natural_empleado FOREIGN KEY (persona_id) REFERENCES personas_naturales(id),
FOREIGN KEY (sucursal_id) REFERENCES sucursales(id),
FOREIGN KEY (supervisor_id) REFERENCES empleados(id)
);
GO

EXEC sp_help empleados;

--Pagos
CREATE TABLE pagos (
id INT PRIMARY KEY IDENTITY (1,1),
metodo_pago_id INT NOT NULL,
codigo_operacion VARCHAR(20) NOT NULL,
monto_pagado MONEY NOT NULL,
estado VARCHAR(55) NOT NULL,
fecha_pago DATETIME DEFAULT GETDATE(),
--Se añadira nuevos detalles por auditoria y se recomienda poner en tb transaccionales
created_at datetime2 NOT NULL,
updated_at datetime2 NULL,
deleted_at datetime2 NULL,
created_by int NOT NULL,
updated_by int NULL,
deleted_by int NULL,

FOREIGN KEY (metodo_pago_id) REFERENCES metodos_pago(id)

);
GO

DROP TABLE pagos

--Prestamos
CREATE TABLE prestamos (
id INT PRIMARY KEY IDENTITY (1,1),
cliente_id INT NOT NULL,
sucursal_id INT NOT  NULL,
tipo_prestamo_id INT NOT NULL,
oficial_credito_id INT NOT NULL,
estado_prestamo VARCHAR(55) NOT NULL,
monto MONEY NOT NULL,
tasa_interes DECIMAL(9,4) NOT NULL,
plazo_meses INT NOT NULL,
fecha_inicio DATETIME DEFAULT GETDATE() NOT NULL,

FOREIGN KEY (cliente_id) REFERENCES clientes(id),
FOREIGN KEY (sucursal_id) REFERENCES sucursales(id),
FOREIGN KEY (tipo_prestamo_id) REFERENCES tipos_prestamos(id),
FOREIGN KEY (oficial_credito_id) REFERENCES empleados(id),
);
GO

EXEC sp_help prestamos;
DROP TABLE prestamos

--Cuota
CREATE TABLE cuotas (
id INT PRIMARY KEY IDENTITY (1,1),
prestamo_id INT NOT NULL,
numero_cuota MONEY NOT NULL,
monto_cuota MONEY NOT NULL,
fecha_vencimiento DATETIME DEFAULT GETDATE() NOT NULL,
FOREIGN KEY (prestamo_id) REFERENCES prestamos(id)
);

--Detalles Cuotas Pagos
CREATE TABLE detalle_cuotas_pagos (
id INT PRIMARY KEY IDENTITY (1,1),
cuota_id INT NOT NULL,
pago_id INT NOT NULL,
saldo_restante MONEY NOT NULL,

);

--Como relacionar la tabla sin tener que eliminar(DROP) la tabla creada
ALTER TABLE detalle_cuotas_pagos
ADD CONSTRAINT fk_detalle_cuotas_pagos_cuotas FOREIGN KEY (cuota_id) REFERENCES cuotas(id)

ALTER TABLE detalle_cuotas_pagos
ADD CONSTRAINT fk_detalle_cuotas_pagos_pagos FOREIGN KEY (pago_id) REFERENCES pagos(id)  
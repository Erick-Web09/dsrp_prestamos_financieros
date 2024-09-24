USE dsrp_prestamos_financieros;
GO

--##############################################################
--		INSERTAR DATOS EN LA TABLA PERSONA JURIDICA
--##############################################################

--Comando para validar si existe data y ver los campos
SELECT*FROM personas_juridicas;



--Comando para ver toda la información de la tabla
EXEC sp_help personas_juridicas;


--Insertar registros en la tb Personas Juridicas
INSERT INTO personas_juridicas (numero_documento,razon_social,domicilio_fiscal,telefono,email)
VALUES ('12345678910','JKC Tecnologia e Informacion','Huaraz-Ancash','321654987','jkc@gmail.com');



INSERT INTO personas_juridicas (numero_documento, razon_social, domicilio_fiscal, telefono, email)
-- Comando para copiar de una lista de una tabla (Prestamos financieros) a otra tabla (Personas juridicas), 
-- PERO HAYA LA PROBABILIDAD DE QUE LOS DATOS SALGAN CON ERRORES Y NO SE TRASPASEN A LA columna correcta.*
SELECT*FROM db_prestamos_financieros.dbo.personas_juridicas; --*



-- Segunda manera de copiar datos de una lista a otra
-- https://www.youtube.com/watch?v=EVc4WJKvCYQ -- Time: 2:20
-- 1°: Se validan que ambos tamblas tengan las mismas cabeceras (A y B)
-- 2°: Una vez validado se procede ejecutar (C y A) 
-- 3: Validar con el comando (B)
INSERT INTO personas_juridicas (numero_documento, razon_social, domicilio_fiscal, telefono, email,fecha_constitucion) -- C
SELECT -- A
	RUC AS 'numero_documento',
	razon_social,
	direccion_fiscal AS 'domicilio_fiscal',
	CONCAT('01',ROUND(RAND()*1000000,0)) AS 'telefono',
	TRIM(LOWER(CONCAT(SUBSTRING(razon_social,1,3),'@gmail.com'))) AS 'email',
	fecha_constitucion
FROM db_prestamos_financieros.dbo.personas_juridicas;

SELECT*FROM personas_juridicas; -- B





-- **El comando COLUMN se utiliza cuando vamos alteral la columna, sino se requiere entonces solo seria ADD (Añadir)**
-- ALTER TABLE personas_juridicas
-- ADD COLUMN fecha_constitucion DATE NOT NULL;

--**Observación: Si ejecutamos con NOT NULL, NO FUNCIONARA, ya que si o si tenemos que eliminar los registros de la tabla
--  personas_juridicads para que añado de manera correcta fecha_constitucion con el atributo NOT NULL
--  Observación 2: Si ya queremos ejecutar sin tener que hacer lo mencionado, se eliminar el "NOT".
ALTER TABLE personas_juridicas
ADD fecha_constitucion DATE NULL;





-- **IMPORTANTE**
-- NOTA: Nunca olvidarse del Where
-- Actualizar fecha constitución registro 31
UPDATE personas_juridicas SET fecha_constitucion = '2020-05-05'
WHERE id=1;



--Comando para eliminar tablas
DROP TABLE personas_juridicas;

--ELIMINAR CONTENIDO DE UNA TABLA
DELETE FROM personas_juridicas;


--Insertar Personas Naturales

SELECT 
	*, TRIM(LOWER(CONCAT(SUBSTRING(nombres,1,1),apellido_paterno,SUBSTRING(apellido_materno,1,1),'@gmail.com'))) AS 'email'
FROM db_prestamos_financieros.dbo.personas_naturales;

SELECT*FROM personas_naturales;










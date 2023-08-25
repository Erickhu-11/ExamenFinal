CREATE DATABASE EXAMENFINAL

CREATE TABLE Encuesta(
ID INT IDENTITY PRIMARY KEY,
Nombre VARCHAR(100),
Genero VARCHAR(20),
Edad INT,
Correo VARCHAR(100),
PartidoPolitico VARCHAR(20));

CREATE TABLE Bitacora_Encuestas(
id INT,
Nombre VARCHAR(100),
Genero VARCHAR(20),
Edad INT,
Correo VARCHAR(100),
Partido VARCHAR(20),
Fecha DATETIME,
Tipo_Tran varchar(10))

CREATE PROCEDURE AgregarEncuesta
@nombre VARCHAR(100),
@genero VARCHAR(20),
@edad INT,
@correo VARCHAR(100),
@partidop VARCHAR(10)
AS
	BEGIN
		INSERT INTO Encuesta VALUES (@nombre, @genero, @edad, @correo, @partidop)
	END

CREATE PROCEDURE ReporteEncuesta
AS
	BEGIN
		SELECT * FROM Encuesta
	END

CREATE PROCEDURE MenuReportes
@operacion INT= 0
AS
	BEGIN
			IF @operacion=1
			BEGIN
			SELECT COUNT(*) FROM Encuesta WHERE genero='Masculino'
			END
			ELSE IF @operacion=2
			BEGIN
			SELECT COUNT(*) FROM Encuesta WHERE genero='Femenino'
			END
			ELSE IF @operacion=3
			BEGIN
			SELECT COUNT(ID) FROM Encuesta
			END
			END

DROP PROCEDURE ReporteGM
ALTER TRIGGER Bitacora_Encuesta
ON Encuesta
AFTER INSERT, DELETE
	AS
		BEGIN
			INSERT INTO Bitacora_Encuestas(id, Nombre, Genero, Edad, Correo, Partido, Fecha, Tipo_Tran)
			SELECT Encuesta.ID, Encuesta.Nombre, Encuesta.Genero, Encuesta.Edad, Encuesta.Correo, Encuesta.PartidoPolitico, GETDATE(), 'AGREGADA'     FROM inserted Encuesta
			UNION ALL
			SELECT Encuesta.ID, Encuesta.Nombre, Encuesta.Genero, Encuesta.Edad, Encuesta.Correo, Encuesta.PartidoPolitico, GETDATE(), 'BORRADA'     FROM deleted Encuesta
		END


EXEC AgregarEncuesta 'Erick','Masculino', '29', 'ehernandezugalde11@gmail.com', 'PLN'
EXEC ReporteEncuesta
EXEC MenuReportes '1'

EXEC AgregarEncuesta 'Krys','Femenino', '20', 'ehernandezugalde11@gmail.com', 'PAC'
EXEC ReporteEncuesta
SELECT*FROM Bitacora_Encuestas


DELETE FROM Bitacora_Encuestas
DELETE FROM Encuesta
DELETE Encuesta WHERE ID=25

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jose Julian Gutierrez, Victor Nuñez
-- Create date: 2/9/22
-- Description:	SP que carga datos de documento XML y los almacena en la base de datos
-- =============================================
ALTER PROCEDURE CargarDatosXML
	@FilePath VARCHAR(100)
AS
BEGIN
      SET NOCOUNT ON;
      DECLARE @xml XML
      DECLARE @SQL NVARCHAR(1000)= 'SET @xml = (SELECT * FROM OPENROWSET (BULK ''' + @FilePath + ''', SINGLE_CLOB) AS XmlData)'
	  --Variable que almacena el XML
      EXEC sp_executesql @SQL, N'@xml XML OUTPUT', @xml OUTPUT; 

	  INSERT INTO ClaseArticulo --Procedimiento para insertar nombre de ClaseArticulo
      SELECT
      TEMPClaseArticulo.value('@Nombre','VARCHAR(64)') AS Nombre 
      FROM
      @xml.nodes('/Datos/ClasesdeArticulos/ClasesdeArticulo')AS TEMPTABLE(TEMPClaseArticulo)
--------------------------------------------------------------------------------------------------

	  INSERT INTO Articulo --Procedimiento para insertar nombre y precio de Articulo
      SELECT
	  (
		SELECT id FROM ClaseArticulo WHERE Nombre LIKE '%' + TEMPArticulo.value('@ClasedeArticulo','VARCHAR(128)') + '%'
		) AS IdClaseArticulo, 
	  TEMPArticulo.value('@Nombre','VARCHAR(128)') AS Nombre,
      TEMPArticulo.value('@Precio','VARCHAR(128)') AS Precio 
      FROM
      @xml.nodes('/Datos/Articulos/Articulo')AS TEMPTABLE(TEMPArticulo)
--------------------------------------------------------------------------------------------------------
INSERT INTO Usuario --Procedimiento para insertar nombre y password de Usuario
      SELECT
      TEMPUsuario.value('@Nombre','VARCHAR(32)') AS UserName, 
	  TEMPUsuario.value('@Password','VARCHAR(32)') AS Password 
      FROM
      @xml.nodes('/Datos/Usuarios/Usuario')AS TEMPTABLE(TEMPUsuario)

END

--EXEC CargarDatosXML 'C:\datosXML.xml'
--SELECT * FROM ClaseArticulo
--SELECT * FROM Articulo
--SELECT * FROM Usuario
--DELETE ClaseArticulo
--DELETE Articulo
--DELETE Usuario
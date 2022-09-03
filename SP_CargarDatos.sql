-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE CargarDatosXML
	@FilePath VARCHAR(100)
AS
BEGIN
      SET NOCOUNT ON;
      DECLARE @xml XML
      DECLARE @SQL NVARCHAR(1000)= 'SET @xml = (SELECT * FROM OPENROWSET (BULK ''' + @FilePath + ''', SINGLE_CLOB) AS XmlData)'
      EXEC sp_executesql @SQL, N'@xml XML OUTPUT', @xml OUTPUT;

	  INSERT INTO ClaseArticulo --COMENTAR
      SELECT
      TEMPClaseArticulo.value('@Nombre','VARCHAR(64)') AS Nombre --TAG
      FROM
      @xml.nodes('/Datos/ClasesdeArticulos/ClasesdeArticulo')AS TEMPTABLE(TEMPClaseArticulo)
--------------------------------------------------------------------------------------------------

	  INSERT INTO Articulo --COMENTAR
      SELECT
	  (
		SELECT id FROM ClaseArticulo WHERE Nombre LIKE '%' + TEMPArticulo.value('@ClasedeArticulo','VARCHAR(128)') + '%'
		) AS IdClaseArticulo,
	  TEMPArticulo.value('@Nombre','VARCHAR(128)') AS Nombre,
      TEMPArticulo.value('@Precio','VARCHAR(128)') AS Precio 
      FROM
      @xml.nodes('/Datos/Articulos/Articulo')AS TEMPTABLE(TEMPArticulo)
--------------------------------------------------------------------------------------------------------
INSERT INTO Usuario --COMENTAR
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

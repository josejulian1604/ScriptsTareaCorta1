USE [Tarea1]
GO
/****** Object:  StoredProcedure [dbo].[FiltrarArticulosPorClase]    Script Date: 4/9/2022 19:54:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jose Julian Gutierrez, Victor Nuñez>
-- Create date: <4/9/2022>
-- Description:	<SP que consiste en Filtrar los articulos por su Clase, escribiendo una Clase especifica>
-- =============================================
ALTER PROCEDURE [dbo].[FiltrarArticulosPorClase]
	
	@Clase VARCHAR(128)
	
AS
BEGIN

	SET NOCOUNT ON;

	SELECT A.id, C.Nombre AS ClaseArticulo , A.Nombre AS Articulo, A.Precio  --Desplieque de las tablas

	FROM Articulo A
		INNER JOIN ClaseArticulo C ON C.id = A.idClaseArticulo -- Permite ligar las tablas

	WHERE (C.Nombre LIKE '%' + @Clase + '%') -- Compara lo solicitado por el usuario con todos las clases de articulo de las tablas
	
	ORDER BY ClaseArticulo -- Lo ordena por orden alfabetico


END

--EXEC FiltrarArticulosPorClase 'elemento'

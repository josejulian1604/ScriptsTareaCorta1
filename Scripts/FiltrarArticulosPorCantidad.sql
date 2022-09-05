USE [Tarea1]
GO
/****** Object:  StoredProcedure [dbo].[FiltrarArticulosPorCantidad]    Script Date: 4/9/2022 19:05:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jose Julian Gutierrez, Victor Nuñez>
-- Create date: <4/9/2022>
-- Description:	<SP que consiste en Filtrar los articulos por su precio, escribiendo una cantidad especifica>
-- =============================================
ALTER PROCEDURE [dbo].[FiltrarArticulosPorCantidad]
	
	@Cantidad VARCHAR(128)
	
AS
BEGIN

	SET NOCOUNT ON;

	SELECT A.id, A.Nombre AS Articulo, A.Precio, C.Nombre AS ClaseArticulo  --Desplieque de las tablas

	FROM Articulo A
		INNER JOIN ClaseArticulo C ON C.id = A.idClaseArticulo -- Permite ligar las tablas

	WHERE (A.Precio LIKE '%' + @Cantidad + '%') -- Compara lo solicitado por el usuario con todos los precios de las tablas
	
	ORDER BY Articulo -- Lo ordena por orden alfabetico


END

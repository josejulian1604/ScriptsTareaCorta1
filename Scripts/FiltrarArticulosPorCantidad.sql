USE [Tarea1]
GO
/****** Object:  StoredProcedure [dbo].[FiltrarArticulosPorCantidad]    Script Date: 6/9/2022 21:30:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Jose Julian Gutierrez, Victor Nuñez>
-- Create date: <4/9/2022>
-- Description:	<SP que consiste en Desplegar los primeros N elementos, este N es proporcionado por ell usuario>
-- =============================================

ALTER PROCEDURE [dbo].[FiltrarArticulosPorCantidad]
	
	@Cantidad INT
	
AS
BEGIN

	SET NOCOUNT ON;

	SELECT A.id, A.Nombre AS Articulo, A.Precio, C.Nombre AS ClaseArticulo


	--Esta parte se encarga de ligar las tablas

	FROM Articulo A
		INNER JOIN ClaseArticulo C ON C.id = A.idClaseArticulo 


	-- Estas lineas ordenan y delimitan los articulos mostrados

	ORDER BY Articulo
	OFFSET 1 ROW
	FETCH NEXT @Cantidad ROWS ONLY


END

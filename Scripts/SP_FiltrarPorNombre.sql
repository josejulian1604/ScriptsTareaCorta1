SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Jose Julian Gutierrez, Victor Nuñez
-- Create date: 2/9/22
-- Description:	SP que filtra articulos por nombre y retorna todos los articulos que contengan ese nombre
-- =============================================
ALTER PROCEDURE FiltrarArticulosPorNombre
@Nombre VARCHAR(128)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT A.id, A.Nombre AS Articulo, A.Precio, C.Nombre AS ClaseArticulo
	FROM Articulo A
		INNER JOIN ClaseArticulo C ON C.id = A.idClaseArticulo --forma de ligar tablas
	WHERE A.Nombre LIKE '%' + @Nombre + '%'; --Captura todos los articulos que contengan ese nombre
END
GO

EXEC FiltrarArticulosPorNombre 'Tiradores'
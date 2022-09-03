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
	WHERE A.Nombre LIKE '%' + @Nombre + '%';
END
GO

EXEC FiltrarArticulosPorNombre 'Tiradores'
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE InsertarArticulo
	-- Add the parameters for the stored procedure here
	@IdClaseArticulo INT,
	@Nombre VARCHAR(128),
	@Precio MONEY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	 IF(NOT EXISTS(SELECT * FROM Articulo WHERE Nombre = @Nombre))
		BEGIN
			INSERT INTO [dbo].[Articulo]
				([IdClaseArticulo]
				,[Nombre]
				,[Precio])
			VALUES
				(@IdClaseArticulo
				,@Nombre
				,@Precio)
			SELECT 0 --Si se pudo insertar el articulo
		END
	ELSE
		BEGIN
			SELECT 1 --No se pudo insertar el articulo
		END
END
USE [Tarea1]
GO
/****** Object:  StoredProcedure [dbo].[obtainIdClaseArticulo]    Script Date: 9/7/2022 8:16:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[obtainIdClaseArticulo]
	-- Add the parameters for the stored procedure here
	@Nombre VARCHAR(64)
AS
BEGIN
		
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT C.id 
	FROM ClaseArticulo C
	WHERE C.Nombre LIKE '%' + @Nombre + '%';
END
USE [sistema_turnos]
GO
/****** Object:  StoredProcedure [dbo].[get_next_reservation_id]    Script Date: 18/11/2024 17:38:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[get_next_reservation_id]
	@start_date datetime,
	@end_date datetime,
	@category_id nvarchar(50)
AS
BEGIN
	-- TODO
	select null
END

USE [sistema_turnos]
GO
/****** Object:  StoredProcedure [dbo].[get_reservations]    Script Date: 18/11/2024 17:39:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[get_reservations]
	@start_date datetime null = null,
	@end_date datetime null = null,
	@category_id nvarchar(10) null = null,
	@client_name nvarchar(10) null = null
AS
BEGIN
	select * from reservations r
	where (
		@start_date is null or r.start_date > @start_date and
		@end_date is null or r.end_date < @end_date and
		@category_id is null or r.category_id = @category_id and
		@client_name is null or r.client_name = @client_name
		)
END

USE [sistema_turnos]
GO
/****** Object:  StoredProcedure [dbo].[create_reservation]    Script Date: 18/11/2024 17:47:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[create_reservation]
	@start_date datetime,
	@end_date datetime,
	@category_id nvarchar(50),
	@client_name nvarchar(50),
	@user_id bigint
AS
BEGIN
	declare @can_make_reservation int
	exec @can_make_reservation = can_make_reservation @start_date, @end_date, @category_id, @user_id

	if @can_make_reservation = 0
		return null
	
	declare @duration bigint
	set @duration = (select DATEDIFF(MINUTE, @start_date, @end_date))
	begin transaction
	insert into reservations (start_date, end_date, category_id, client_name, duration, created_by)
	values (
		@start_date,
		@end_date,
		@category_id,
		@client_name,
		@duration,
		@user_id
	)
	commit

	return SCOPE_IDENTITY();
END

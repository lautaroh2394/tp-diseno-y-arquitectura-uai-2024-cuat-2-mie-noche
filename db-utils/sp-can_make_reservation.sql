USE [sistema_turnos]
GO
/****** Object:  StoredProcedure [dbo].[can_make_reservation]    Script Date: 18/11/2024 17:37:27 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[can_make_reservation]
	@start_date datetime,
	@end_date datetime,
	@category_id nvarchar(50),
	@user_id bigint
AS
BEGIN
	-- validate duration is not bigger that what is allowed
	declare @duration bigint
	set @duration = (select DATEDIFF(MINUTE, @start_date, @end_date))

	declare @max_duration bigint
	set @max_duration = (select value from settings where setting_key = 'MAX_DURATION')

	if (@max_duration < @duration and @duration <= 0) return 0

	-- validate reservation is not before opening hours
	declare @opening_hours int;
	set @opening_hours = (select value from settings where setting_key = 'OPENING_HOUR')
	if (FORMAT(@start_date, 'HH') < @opening_hours) return 0

	-- validate reservation is not after closing hours
	declare @closing_hours int;
	set @closing_hours = (select value from settings where setting_key = 'CLOSING_HOUR')
	if (FORMAT(@end_date, 'HH') > @closing_hours ) return 0

	-- validate user is allowed to create reservation
	if (select dbo.is_user_allowed(@user_id, 'RESERVA')) = 0
		return 0

	-- validate timeframe is not overlapping with existing reservations
	if (select dbo.do_overlapping_reservations_exist(
		@start_date, 
		@end_date,
		@category_id)) = 1
		return 0

	return 1
END

USE [sistema_turnos]
GO
/****** Object:  UserDefinedFunction [dbo].[do_overlapping_reservations_exist]    Script Date: 18/11/2024 17:36:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[do_overlapping_reservations_exist](
	@start_date datetime,
	@end_date datetime,
	@category_id nvarchar(50))
returns bit
AS
BEGIN
	DECLARE @result BIT = 0;
	if exists(
	select top 1 1 from reservations r where
		r.category_id = @category_id and (
		-- starts before and ends during other reservation
		(r.start_date <= @start_date AND  @end_date <= @end_date AND  r.end_date > @start_date) or
		-- start during other reservation and ends after
		(r.start_date >= @start_date AND  r.end_date >= @end_date AND  r.start_date <= @end_date ) or
		-- starts before and ends after other reservation
		(r.start_date <= @start_date AND  r.end_date >= @end_date ))
		) set @result = 1;
	RETURN @result
END

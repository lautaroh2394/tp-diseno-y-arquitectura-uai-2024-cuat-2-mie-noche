USE [sistema_turnos]
GO
/****** Object:  StoredProcedure [dbo].[get_today_reservations]    Script Date: 18/11/2024 17:39:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[get_today_reservations](
	@category_id nvarchar(10) null = null,
	@client_name nvarchar(10) null = null
	)
AS
BEGIN
	declare @opening_hours bigint;
	declare @closing_hours bigint;
	declare @today_date_opening datetime;
	declare @today_date_closing datetime;
		
	set @opening_hours = (select value from settings where setting_key = 'OPENING_HOUR');
	set @closing_hours = (select value from settings where setting_key = 'CLOSING_HOUR');
	set @today_date_opening = (select CAST(CONVERT(date, GETDATE()) AS datetime) + CAST(concat(@opening_hours, ':00:00') AS datetime));
	set @today_date_closing = (select CAST(CONVERT(date, GETDATE()) AS datetime) + CAST(concat(@closing_hours, ':00:00') AS datetime));

	exec get_reservations 
		@today_date_opening,
		@today_date_closing,
		@category_id,
		@client_name;
END

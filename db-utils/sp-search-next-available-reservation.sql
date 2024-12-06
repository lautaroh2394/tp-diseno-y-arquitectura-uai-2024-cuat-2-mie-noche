USE [sistema_turnos]
GO
/****** Object:  StoredProcedure [dbo].[search_next_available_reservation]    Script Date: 18/11/2024 17:40:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[search_next_available_reservation]
	@min_duration int,
	@category_id nvarchar(50)
AS
BEGIN
	return SELECT top 1
		r1.end_date AS proposed_start_date, 
		r2.start_date AS proposed_end_date
	FROM 
		reservations r1
	JOIN 
		reservations r2 ON r1.end_date <= r2.start_date
	WHERE 
		r1.end_date > GETDATE() and
		(DATEDIFF(MINUTE, r1.end_date, r2.start_date) >= @min_duration ) and 
		(dbo.do_overlapping_reservations_exist(
			r1.end_date, 
			r2.start_date,
			@category_id)) = 0

	ORDER BY 
		r1.end_date asc
END

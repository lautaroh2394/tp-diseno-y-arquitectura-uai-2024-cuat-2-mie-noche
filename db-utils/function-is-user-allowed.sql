USE [sistema_turnos]
GO
/****** Object:  UserDefinedFunction [dbo].[is_user_allowed]    Script Date: 18/11/2024 17:37:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER FUNCTION [dbo].[is_user_allowed] (
	@user_id bigint,
	@permission_id nvarchar(50)
	)
returns bit
as
begin
	declare @is_allowed bit = 0
	if exists (select top 1 1 from permissions_per_user where
		user_id = @user_id and
		(
			permission_id = @permission_id or
			permission_id = 'ADMIN'
		))
		set @is_allowed = 1

	return @is_allowed
end 
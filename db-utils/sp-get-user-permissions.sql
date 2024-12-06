USE [sistema_turnos]
GO
/****** Object:  StoredProcedure [dbo].[get_user_permissions]    Script Date: 18/11/2024 17:40:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[get_user_permissions]
	@userId BIGINT
AS
BEGIN
	SELECT p.id, p.name, p.show_name FROM users u
	JOIN permissions_per_user pu on pu.user_id = u.id
	JOIN dbo.permissions p on pu.permission_id = p.id
	where u.id = @userId
END

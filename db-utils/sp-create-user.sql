USE [sistema_turnos]
GO
/****** Object:  StoredProcedure [dbo].[create_user]    Script Date: 18/11/2024 17:37:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[create_user]
	-- Add the parameters for the stored procedure here
	@username nvarchar(10),
	@hashed_password nvarchar(10),
	@permissions_list PermissionsListType READONLY
AS
BEGIN
	insert into users (username, password)
	values (@username, @hashed_password);

	declare @user_id bigint;
	set @user_id = (select id from users where username = @username);

	INSERT INTO permissions_per_user (user_id, permission_id)
    SELECT @user_id, p.id
    FROM @permissions_list p

END

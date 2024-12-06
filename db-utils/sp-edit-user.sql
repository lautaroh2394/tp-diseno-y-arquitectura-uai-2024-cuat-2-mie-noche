USE [sistema_turnos]
GO
/****** Object:  StoredProcedure [dbo].[edit_user]    Script Date: 18/11/2024 17:38:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[edit_user]
	@user_id bigint,
	@new_hashed_password nvarchar(10) null,
	@permissions_list PermissionsListType READONLY
AS
BEGIN
	if (@new_hashed_password is not null)
		update users
		set password = @new_hashed_password 
		where id = @user_id

	delete from permissions_per_user where user_id = @user_id

	INSERT INTO permissions_per_user (user_id, permission_id)
	SELECT @user_id, p.id
	FROM @permissions_list p
END

USE [sistema_turnos]
GO
/****** Object:  UserDefinedFunction [dbo].[authenticate_user]    Script Date: 18/11/2024 17:35:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER FUNCTION [dbo].[authenticate_user] (@username NVARCHAR(10), @hashedPassword NVARCHAR(10))
RETURNS BIT
AS
BEGIN
    DECLARE @validCredentials BIT
	DECLARE @savedHashedPassword BIT

	SET @savedHashedPassword = (SELECT password FROM users WHERE username = @username );
    
	IF @savedHashedPassword = @hashedPassword
        SET @validCredentials= 1
    ELSE
        SET @validCredentials = 0

    RETURN @validCredentials
END

USE [master]
GO
/****** Object:  Database [sistema_turnos]    Script Date: 14/12/2024 21:53:42 ******/
CREATE DATABASE [sistema_turnos]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'sistema_turnos', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\sistema_turnos.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'sistema_turnos_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\sistema_turnos_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [sistema_turnos] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [sistema_turnos].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [sistema_turnos] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [sistema_turnos] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [sistema_turnos] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [sistema_turnos] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [sistema_turnos] SET ARITHABORT OFF 
GO
ALTER DATABASE [sistema_turnos] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [sistema_turnos] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [sistema_turnos] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [sistema_turnos] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [sistema_turnos] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [sistema_turnos] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [sistema_turnos] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [sistema_turnos] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [sistema_turnos] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [sistema_turnos] SET  DISABLE_BROKER 
GO
ALTER DATABASE [sistema_turnos] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [sistema_turnos] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [sistema_turnos] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [sistema_turnos] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [sistema_turnos] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [sistema_turnos] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [sistema_turnos] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [sistema_turnos] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [sistema_turnos] SET  MULTI_USER 
GO
ALTER DATABASE [sistema_turnos] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [sistema_turnos] SET DB_CHAINING OFF 
GO
ALTER DATABASE [sistema_turnos] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [sistema_turnos] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [sistema_turnos] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [sistema_turnos] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [sistema_turnos] SET QUERY_STORE = OFF
GO
USE [sistema_turnos]
GO
/****** Object:  User [webserver]    Script Date: 14/12/2024 21:53:42 ******/
CREATE USER [webserver] FOR LOGIN [webserver] WITH DEFAULT_SCHEMA=[sistema_turnos]
GO
/****** Object:  UserDefinedTableType [dbo].[PermissionsListType]    Script Date: 14/12/2024 21:53:42 ******/
CREATE TYPE [dbo].[PermissionsListType] AS TABLE(
	[id] [nvarchar](50) NULL
)
GO
/****** Object:  UserDefinedFunction [dbo].[do_overlapping_reservations_exist]    Script Date: 14/12/2024 21:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[do_overlapping_reservations_exist](
	@start_date datetime,
	@end_date datetime,
	@category_id nvarchar(50)
	)
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
		(r.start_date <= @start_date AND  r.end_date >= @end_date ) or
		-- starts after and ends before other reservation
		(r.start_date >= @start_date AND  r.end_date <= @end_date)
		)) set @result = 1;
	RETURN @result
END
GO
/****** Object:  UserDefinedFunction [dbo].[is_user_allowed]    Script Date: 14/12/2024 21:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[is_user_allowed] (
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
GO
/****** Object:  Table [dbo].[users]    Script Date: 14/12/2024 21:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[users](
	[username] [nvarchar](64) NOT NULL,
	[password] [nvarchar](64) NOT NULL,
	[id] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_users] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [unique_user] UNIQUE NONCLUSTERED 
(
	[username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[users_view]    Script Date: 14/12/2024 21:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[users_view] AS
SELECT id, username FROM users

GO
/****** Object:  Table [dbo].[categories]    Script Date: 14/12/2024 21:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[categories](
	[id] [nvarchar](50) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[show_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_categories] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[permissions]    Script Date: 14/12/2024 21:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[permissions](
	[id] [nvarchar](50) NOT NULL,
	[name] [nvarchar](50) NOT NULL,
	[show_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_permissions] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[permissions_per_user]    Script Date: 14/12/2024 21:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[permissions_per_user](
	[user_id] [bigint] NOT NULL,
	[permission_id] [nvarchar](50) NOT NULL,
	[id] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_permissions_per_user] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[reservations]    Script Date: 14/12/2024 21:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[reservations](
	[duration] [int] NOT NULL,
	[start_date] [datetime] NOT NULL,
	[end_date] [datetime] NOT NULL,
	[category_id] [nvarchar](50) NOT NULL,
	[client_name] [nchar](50) NOT NULL,
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[created_by] [bigint] NOT NULL,
 CONSTRAINT [PK_reservations] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[settings]    Script Date: 14/12/2024 21:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[settings](
	[setting_key] [nvarchar](50) NOT NULL,
	[value] [nchar](50) NOT NULL,
 CONSTRAINT [PK_settings_1] PRIMARY KEY CLUSTERED 
(
	[setting_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[permissions_per_user]  WITH CHECK ADD  CONSTRAINT [FK_permissions_per_user_permissions] FOREIGN KEY([permission_id])
REFERENCES [dbo].[permissions] ([id])
GO
ALTER TABLE [dbo].[permissions_per_user] CHECK CONSTRAINT [FK_permissions_per_user_permissions]
GO
ALTER TABLE [dbo].[permissions_per_user]  WITH CHECK ADD  CONSTRAINT [FK_permissions_per_user_users] FOREIGN KEY([user_id])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[permissions_per_user] CHECK CONSTRAINT [FK_permissions_per_user_users]
GO
ALTER TABLE [dbo].[reservations]  WITH CHECK ADD  CONSTRAINT [FK_reservations_categories] FOREIGN KEY([category_id])
REFERENCES [dbo].[categories] ([id])
GO
ALTER TABLE [dbo].[reservations] CHECK CONSTRAINT [FK_reservations_categories]
GO
ALTER TABLE [dbo].[reservations]  WITH CHECK ADD  CONSTRAINT [FK_reservations_users] FOREIGN KEY([created_by])
REFERENCES [dbo].[users] ([id])
GO
ALTER TABLE [dbo].[reservations] CHECK CONSTRAINT [FK_reservations_users]
GO
/****** Object:  StoredProcedure [dbo].[authenticate_user]    Script Date: 14/12/2024 21:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[authenticate_user] (@username NVARCHAR(64), @hashedPassword NVARCHAR(64))
AS
BEGIN
    DECLARE @validCredentials BIT
	DECLARE @savedHashedPassword nvarchar(64)

	SET @savedHashedPassword = (SELECT password FROM users WHERE username = @username );
    
	IF @savedHashedPassword = @hashedPassword
        SET @validCredentials= 1
    ELSE
        SET @validCredentials = 0

    select @validCredentials as 'valid'
END
GO
/****** Object:  StoredProcedure [dbo].[can_make_reservation]    Script Date: 14/12/2024 21:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[can_make_reservation]
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
GO
/****** Object:  StoredProcedure [dbo].[create_reservation]    Script Date: 14/12/2024 21:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[create_reservation]
	@start_date datetime,
	@end_date datetime,
	@category_id nvarchar(50),
	@client_name nvarchar(50),
	@user_id bigint,
	@id bigint OUTPUT
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

	set @id = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[create_user]    Script Date: 14/12/2024 21:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[create_user]
	-- Add the parameters for the stored procedure here
	@username nvarchar(64),
	@hashed_password nvarchar(64),
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
GO
/****** Object:  StoredProcedure [dbo].[get_next_reservation_id]    Script Date: 14/12/2024 21:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[get_next_reservation_id]
	@start_date datetime,
	@end_date datetime,
	@category_id nvarchar(50)
AS
BEGIN
	-- TODO
	select null
END
GO
/****** Object:  StoredProcedure [dbo].[get_previous_reservation_id]    Script Date: 14/12/2024 21:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[get_previous_reservation_id]
	@start_date datetime,
	@end_date datetime,
	@category_id nvarchar(50)
AS
BEGIN
	-- TODO
	select null
END
GO
/****** Object:  StoredProcedure [dbo].[get_reservation]    Script Date: 14/12/2024 21:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[get_reservation]
	@id bigint,
	@duration int OUTPUT,
	@start_date nvarchar(50)  output ,
	@end_date nvarchar(50) output ,
	@category_id nvarchar(50) output ,
	@client_name nvarchar(50) output ,
	@created_by nvarchar(50) output 
AS
BEGIN
	select top 1 
		@duration = duration,
		@start_date = start_date,
		@end_date = end_date,
		@category_id = category_id,
		@client_name = client_name,
		@created_by = created_by
	from reservations r
	where (id = @id)
END
GO
/****** Object:  StoredProcedure [dbo].[get_reservations]    Script Date: 14/12/2024 21:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[get_reservations]
	@start_date datetime null = null,
	@end_date datetime null = null,
	@category_id nvarchar(50) null = null,
	@client_name nvarchar(50) null = null
AS
BEGIN
	select * from reservations r
	where (
		(@start_date is null or r.start_date > @start_date) and
		(@end_date is null or r.end_date < @end_date) and
		(@category_id is null or r.category_id = @category_id) and
		(@client_name is null or r.client_name like '%' + @client_name + '%')
		)
END
GO
/****** Object:  StoredProcedure [dbo].[get_today_reservations]    Script Date: 14/12/2024 21:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[get_today_reservations](
	@category_id nvarchar(50) null = null,
	@client_name nvarchar(50) null = null
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
GO
/****** Object:  StoredProcedure [dbo].[get_user_permissions]    Script Date: 14/12/2024 21:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[get_user_permissions]
	@userId BIGINT
AS
BEGIN
	SELECT p.id, p.name, p.show_name FROM users u
	JOIN permissions_per_user pu on pu.user_id = u.id
	JOIN dbo.permissions p on pu.permission_id = p.id
	where u.id = @userId
END
GO
/****** Object:  StoredProcedure [dbo].[search_next_available_reservation]    Script Date: 14/12/2024 21:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[search_next_available_reservation]
	@category_id nvarchar(50),
	@start_date datetime = null,
	@end_date datetime = null
AS
BEGIN
	declare @min_duration int = (select value from settings where setting_key = 'MAX_DURATION')

	SELECT top 1
		r1.end_date AS proposed_start_date, 
		r2.start_date AS proposed_end_date
	FROM 
		reservations r1
	JOIN 
		reservations r2 ON r1.end_date <= r2.start_date
	WHERE 
		r1.end_date > GETDATE() and
		(@start_date is null or r1.end_date < @start_date ) and
		(@end_date is null or r2.start_date > @end_date) and
		(DATEDIFF(MINUTE, r1.end_date, r2.start_date) >= @min_duration ) and 
		(dbo.do_overlapping_reservations_exist(
			r1.end_date, 
			r2.start_date,
			@category_id)) = 0

	ORDER BY 
		r1.end_date asc
END
GO
/****** Object:  StoredProcedure [dbo].[update_reservation]    Script Date: 14/12/2024 21:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[update_reservation]
	@id int,
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
	update reservations
	set start_date = @start_date,
		end_date = @end_date,
		category_id = @category_id,
		client_name = @client_name,
		duration = @duration
	where id = @id
	commit
END
GO
/****** Object:  StoredProcedure [dbo].[update_user]    Script Date: 14/12/2024 21:53:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[update_user]
	@user_id bigint,
	@new_hashed_password nvarchar(64) null = null,
	@permissions_list PermissionsListType READONLY
AS
BEGIN
	begin transaction
	if (@new_hashed_password is not null)
		update users
		set password = @new_hashed_password 
		where id = @user_id

	delete from permissions_per_user where user_id = @user_id

	INSERT INTO permissions_per_user (user_id, permission_id)
	SELECT @user_id, p.id
	FROM @permissions_list p
	commit
END

GO
USE [master]
GO
ALTER DATABASE [sistema_turnos] SET  READ_WRITE 
GO

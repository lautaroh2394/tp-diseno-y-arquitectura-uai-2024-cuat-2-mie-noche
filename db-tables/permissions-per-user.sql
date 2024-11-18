USE [sistema_turnos]
GO

/****** Object:  Table [dbo].[permissions_per_user]    Script Date: 18/11/2024 17:42:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[permissions_per_user](
	[user_id] [bigint] NOT NULL,
	[permission_id] [nchar](50) NOT NULL,
	[id] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_permissions_per_user] PRIMARY KEY CLUSTERED 
(
	[id] ASC
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



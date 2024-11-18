USE [sistema_turnos]
GO

/****** Object:  Table [dbo].[reservations]    Script Date: 18/11/2024 17:42:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[reservations](
	[duration] [int] NOT NULL,
	[start_date] [datetime] NOT NULL,
	[end_date] [datetime] NOT NULL,
	[category_id] [nchar](50) NOT NULL,
	[client_name] [nchar](50) NOT NULL,
	[previous_reservation] [bigint] NULL,
	[next_reservation] [bigint] NULL,
	[id] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_reservations] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[reservations]  WITH CHECK ADD  CONSTRAINT [FK_reservations_categories] FOREIGN KEY([category_id])
REFERENCES [dbo].[categories] ([id])
GO

ALTER TABLE [dbo].[reservations] CHECK CONSTRAINT [FK_reservations_categories]
GO



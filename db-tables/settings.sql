USE [sistema_turnos]
GO

/****** Object:  Table [dbo].[settings]    Script Date: 18/11/2024 17:42:48 ******/
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



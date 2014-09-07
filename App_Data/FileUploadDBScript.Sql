SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FilesContent](
	[FileID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[FileContent] [varbinary](max) NULL,
	[FileName] [varchar](50) NULL,
	[FileExtension] [varchar](50) NULL,
 CONSTRAINT [PK_FilesContent] PRIMARY KEY CLUSTERED 
(
	[FileID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
-----------------------------------------------------------------------------------------------------------------------------------------
SET ANSI_PADDING OFF
GO
CREATE PROCEDURE dbo.SaveFilesInDB
    (
    @FileContent VARBINARY(MAX),
    @FileName VARCHAR(50),
    @FileExtension VARCHAR(50)
    )
AS
BEGIN
INSERT INTO FilesContent(FileContent,FileName,FileExtension) VALUES (@FileContent,@FileName,@FileExtension)
END
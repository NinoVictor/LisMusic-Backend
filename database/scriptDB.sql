USE [LisMusicDB]
GO
/****** Object:  Table [dbo].[Tracks]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tracks](
	[IdTrack] [nvarchar](50) NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Duration] [float] NOT NULL,
	[Reproductions] [int] NOT NULL,
	[FileTrack] [nvarchar](50) NOT NULL,
	[Avaible] [bit] NULL,
	[IdAlbum] [nvarchar](50) NULL,
 CONSTRAINT [PK_Tracks] PRIMARY KEY CLUSTERED 
(
	[IdTrack] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Albums]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Albums](
	[IdAlbum] [nvarchar](50) NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Cover] [nvarchar](50) NOT NULL,
	[Publication] [date] NOT NULL,
	[RecordCompany] [nvarchar](50) NOT NULL,
	[IdMusicGender] [int] NOT NULL,
	[IdAlbumType] [int] NOT NULL,
	[IdArtist] [nvarchar](50) NULL,
 CONSTRAINT [PK_Albums] PRIMARY KEY CLUSTERED 
(
	[IdAlbum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Artists]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Artists](
	[IdArtist] [nvarchar](50) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Cover] [nvarchar](50) NULL,
	[RegisterDate] [date] NOT NULL,
	[Description] [text] NULL,
 CONSTRAINT [PK_Artists] PRIMARY KEY CLUSTERED 
(
	[IdArtist] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[TracksArtist]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[TracksArtist]
AS
SELECT        TOP (100) PERCENT dbo.Artists.Name, dbo.Artists.Cover, dbo.Tracks.Title, dbo.Albums.Cover AS AlbumCover, dbo.Tracks.Duration, dbo.Tracks.FileTrack, dbo.Tracks.Avaible, dbo.Artists.IdArtist
FROM            dbo.Artists INNER JOIN
                         dbo.Albums ON dbo.Artists.IdArtist = dbo.Albums.IdArtist INNER JOIN
                         dbo.Tracks ON dbo.Albums.IdAlbum = dbo.Tracks.IdAlbum
GO
/****** Object:  View [dbo].[ArtistAlbumTrack]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ArtistAlbumTrack]
AS
SELECT        dbo.Artists.IdArtist, dbo.Artists.Name, dbo.Albums.IdAlbum, dbo.Albums.Title AS Album_Title, dbo.Albums.Cover, dbo.Tracks.IdTrack, dbo.Tracks.Title AS Track_Title, dbo.Tracks.Duration, dbo.Tracks.FileTrack, 
                         dbo.Tracks.Avaible
FROM            dbo.Albums INNER JOIN
                         dbo.Artists ON dbo.Albums.IdArtist = dbo.Artists.IdArtist INNER JOIN
                         dbo.Tracks ON dbo.Albums.IdAlbum = dbo.Tracks.IdAlbum
GO
/****** Object:  Table [dbo].[MusicGenders]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MusicGenders](
	[IdMusicGender] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[GenderName] [nvarchar](100) NOT NULL,
	[Cover] [nvarchar](50) NULL,
 CONSTRAINT [PK_MusicGenders] PRIMARY KEY CLUSTERED 
(
	[IdMusicGender] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[MusicGendersTracksAlbum]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[MusicGendersTracksAlbum]
AS
SELECT        dbo.MusicGenders.IdMusicGender, dbo.MusicGenders.GenderName, dbo.Tracks.IdTrack, dbo.Tracks.Title AS Track_Title, dbo.Tracks.Duration, dbo.Tracks.FileTrack, dbo.Albums.IdAlbum, dbo.Albums.Cover, 
                         dbo.Albums.Title AS Album_Title
FROM            dbo.Albums INNER JOIN
                         dbo.MusicGenders ON dbo.Albums.IdMusicGender = dbo.MusicGenders.IdMusicGender INNER JOIN
                         dbo.Tracks ON dbo.Albums.IdAlbum = dbo.Tracks.IdAlbum
GO
/****** Object:  Table [dbo].[History]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[History](
	[IdHistory] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ReproductionDate] [date] NOT NULL,
	[IdAccount] [nvarchar](50) NOT NULL,
	[IdTrack] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_History] PRIMARY KEY CLUSTERED 
(
	[IdHistory] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ArtistsHistoryTracks]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[ArtistsHistoryTracks]
AS
SELECT        dbo.Artists.IdArtist, dbo.Artists.Name, dbo.History.ReproductionDate, dbo.Tracks.IdTrack, dbo.Tracks.Title
FROM            dbo.Tracks INNER JOIN
                         dbo.History ON dbo.Tracks.IdTrack = dbo.History.IdTrack INNER JOIN
                         dbo.Albums ON dbo.Tracks.IdAlbum = dbo.Albums.IdAlbum INNER JOIN
                         dbo.Artists ON dbo.Albums.IdArtist = dbo.Artists.IdArtist
GO
/****** Object:  Table [dbo].[Playlists]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Playlists](
	[IdPlaylist] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Creation] [date] NOT NULL,
	[Cover] [nvarchar](50) NULL,
	[PublicPlaylist] [bit] NOT NULL,
	[IdPlaylistType] [int] NOT NULL,
	[IdAccount] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Playlists] PRIMARY KEY CLUSTERED 
(
	[IdPlaylist] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlaylistTracks]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlaylistTracks](
	[IdPlaylistTrack] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[IdPlaylist] [int] NOT NULL,
	[IdTrack] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_PlaylistTracks] PRIMARY KEY CLUSTERED 
(
	[IdPlaylistTrack] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[TracksPlaylistsLike]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[TracksPlaylistsLike]
AS
SELECT        dbo.Playlists.IdPlaylist, dbo.Tracks.IdTrack
FROM            dbo.PlaylistTracks INNER JOIN
                         dbo.Playlists ON dbo.PlaylistTracks.IdPlaylist = dbo.Playlists.IdPlaylist INNER JOIN
                         dbo.Tracks ON dbo.PlaylistTracks.IdTrack = dbo.Tracks.IdTrack
WHERE        (dbo.Playlists.IdPlaylistType = 1)
GO
/****** Object:  Table [dbo].[AccountArtists]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountArtists](
	[IdAccountArtist] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[TermAndConditions] [bit] NULL,
	[IdAccount] [nvarchar](50) NULL,
	[IdArtist] [nvarchar](50) NULL,
 CONSTRAINT [PK_AccountArtists] PRIMARY KEY CLUSTERED 
(
	[IdAccountArtist] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Accounts]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Accounts](
	[IdAccount] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](50) NOT NULL,
	[Password] [nvarchar](260) NULL,
	[UserName] [nvarchar](50) NULL,
	[Gender] [nvarchar](50) NULL,
	[Birthday] [date] NULL,
	[Cover] [nvarchar](50) NULL,
	[CreatedDate] [datetime] NOT NULL,
	[UpdatedDate] [datetime] NULL,
	[ContentCreator] [bit] NOT NULL,
	[IdSocialMedia] [int] NOT NULL,
 CONSTRAINT [PK_Accounts] PRIMARY KEY CLUSTERED 
(
	[IdAccount] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AlbumsTracks]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlbumsTracks](
	[IdAlbumTrack] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[IdAlbum] [nvarchar](50) NOT NULL,
	[IdTrack] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_AlbumsTracks] PRIMARY KEY CLUSTERED 
(
	[IdAlbumTrack] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AlbumTypes]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlbumTypes](
	[IdAlbumType] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[TypeName] [nvarchar](50) NULL,
 CONSTRAINT [PK_AlbumTypes] PRIMARY KEY CLUSTERED 
(
	[IdAlbumType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ArtistsNumbers]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ArtistsNumbers](
	[IdArtistsNumber] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[DateRegister] [date] NOT NULL,
	[NumerArtists] [int] NOT NULL,
 CONSTRAINT [PK_UploadTracks] PRIMARY KEY CLUSTERED 
(
	[IdArtistsNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ArtistsReproductions]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ArtistsReproductions](
	[IdArtistsReproductions] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[IdArtist] [nchar](220) NOT NULL,
	[TotalReproductions] [int] NOT NULL,
 CONSTRAINT [PK_ArtistsReproduction] PRIMARY KEY CLUSTERED 
(
	[IdArtistsReproductions] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PersonalTracks]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonalTracks](
	[IdPersonalTrack] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Title] [nvarchar](50) NOT NULL,
	[Gender] [nvarchar](50) NULL,
	[Album] [nvarchar](50) NULL,
	[Cover] [nvarchar](50) NULL,
	[Duration] [float] NOT NULL,
	[FileTrack] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_PersonalTracks] PRIMARY KEY CLUSTERED 
(
	[IdPersonalTrack] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PersonalTracksAccounts]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PersonalTracksAccounts](
	[IdPersonalTrackAccount] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[IdPersonalTrack] [int] NOT NULL,
	[IdAccount] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_PersonalTracksAccounts] PRIMARY KEY CLUSTERED 
(
	[IdPersonalTrackAccount] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PlaylistTypes]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PlaylistTypes](
	[IdPlaylistType] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[NameType] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_PlaylistTypes] PRIMARY KEY CLUSTERED 
(
	[IdPlaylistType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SocialMedia]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SocialMedia](
	[IdSocialMedia] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_SocialMedia] PRIMARY KEY CLUSTERED 
(
	[IdSocialMedia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TokensUser]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TokensUser](
	[IdToken] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Token] [nvarchar](256) NOT NULL,
	[Active] [bit] NOT NULL,
	[IdAccount] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_TokensUser] PRIMARY KEY CLUSTERED 
(
	[IdToken] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TrackCollaborators]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TrackCollaborators](
	[IdTrackCollaborator] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[IdTrack] [nvarchar](50) NOT NULL,
	[IdArtist] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_TrackCollaborators] PRIMARY KEY CLUSTERED 
(
	[IdTrackCollaborator] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TracksLikesPlaylists]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TracksLikesPlaylists](
	[IdTracksLikesPlaylists] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[IdTrack] [nvarchar](220) NOT NULL,
	[TotalLikes] [int] NOT NULL,
 CONSTRAINT [PK_TracksLikesPlaylists] PRIMARY KEY CLUSTERED 
(
	[IdTracksLikesPlaylists] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AccountArtists]  WITH CHECK ADD  CONSTRAINT [FK_AccountArtists_Accounts] FOREIGN KEY([IdAccount])
REFERENCES [dbo].[Accounts] ([IdAccount])
GO
ALTER TABLE [dbo].[AccountArtists] CHECK CONSTRAINT [FK_AccountArtists_Accounts]
GO
ALTER TABLE [dbo].[AccountArtists]  WITH CHECK ADD  CONSTRAINT [FK_AccountArtists_Artists] FOREIGN KEY([IdArtist])
REFERENCES [dbo].[Artists] ([IdArtist])
GO
ALTER TABLE [dbo].[AccountArtists] CHECK CONSTRAINT [FK_AccountArtists_Artists]
GO
ALTER TABLE [dbo].[Accounts]  WITH CHECK ADD  CONSTRAINT [FK_Accounts_SocialMedia] FOREIGN KEY([IdSocialMedia])
REFERENCES [dbo].[SocialMedia] ([IdSocialMedia])
GO
ALTER TABLE [dbo].[Accounts] CHECK CONSTRAINT [FK_Accounts_SocialMedia]
GO
ALTER TABLE [dbo].[Albums]  WITH CHECK ADD  CONSTRAINT [FK_Albums_AlbumTypes] FOREIGN KEY([IdAlbumType])
REFERENCES [dbo].[AlbumTypes] ([IdAlbumType])
GO
ALTER TABLE [dbo].[Albums] CHECK CONSTRAINT [FK_Albums_AlbumTypes]
GO
ALTER TABLE [dbo].[Albums]  WITH CHECK ADD  CONSTRAINT [FK_Albums_Artists] FOREIGN KEY([IdArtist])
REFERENCES [dbo].[Artists] ([IdArtist])
GO
ALTER TABLE [dbo].[Albums] CHECK CONSTRAINT [FK_Albums_Artists]
GO
ALTER TABLE [dbo].[Albums]  WITH CHECK ADD  CONSTRAINT [FK_Albums_MusicGenders] FOREIGN KEY([IdMusicGender])
REFERENCES [dbo].[MusicGenders] ([IdMusicGender])
GO
ALTER TABLE [dbo].[Albums] CHECK CONSTRAINT [FK_Albums_MusicGenders]
GO
ALTER TABLE [dbo].[AlbumsTracks]  WITH CHECK ADD  CONSTRAINT [FK_AlbumsTracks_Albums] FOREIGN KEY([IdAlbum])
REFERENCES [dbo].[Albums] ([IdAlbum])
GO
ALTER TABLE [dbo].[AlbumsTracks] CHECK CONSTRAINT [FK_AlbumsTracks_Albums]
GO
ALTER TABLE [dbo].[AlbumsTracks]  WITH CHECK ADD  CONSTRAINT [FK_AlbumsTracks_Tracks] FOREIGN KEY([IdTrack])
REFERENCES [dbo].[Tracks] ([IdTrack])
GO
ALTER TABLE [dbo].[AlbumsTracks] CHECK CONSTRAINT [FK_AlbumsTracks_Tracks]
GO
ALTER TABLE [dbo].[History]  WITH CHECK ADD  CONSTRAINT [FK_History_Accounts1] FOREIGN KEY([IdAccount])
REFERENCES [dbo].[Accounts] ([IdAccount])
GO
ALTER TABLE [dbo].[History] CHECK CONSTRAINT [FK_History_Accounts1]
GO
ALTER TABLE [dbo].[History]  WITH CHECK ADD  CONSTRAINT [FK_History_Tracks] FOREIGN KEY([IdTrack])
REFERENCES [dbo].[Tracks] ([IdTrack])
GO
ALTER TABLE [dbo].[History] CHECK CONSTRAINT [FK_History_Tracks]
GO
ALTER TABLE [dbo].[PersonalTracksAccounts]  WITH CHECK ADD  CONSTRAINT [FK_PersonalTracksAccounts_Accounts] FOREIGN KEY([IdAccount])
REFERENCES [dbo].[Accounts] ([IdAccount])
GO
ALTER TABLE [dbo].[PersonalTracksAccounts] CHECK CONSTRAINT [FK_PersonalTracksAccounts_Accounts]
GO
ALTER TABLE [dbo].[PersonalTracksAccounts]  WITH CHECK ADD  CONSTRAINT [FK_PersonalTracksAccounts_PersonalTracks] FOREIGN KEY([IdPersonalTrack])
REFERENCES [dbo].[PersonalTracks] ([IdPersonalTrack])
GO
ALTER TABLE [dbo].[PersonalTracksAccounts] CHECK CONSTRAINT [FK_PersonalTracksAccounts_PersonalTracks]
GO
ALTER TABLE [dbo].[Playlists]  WITH CHECK ADD  CONSTRAINT [FK_Playlists_Accounts] FOREIGN KEY([IdAccount])
REFERENCES [dbo].[Accounts] ([IdAccount])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Playlists] CHECK CONSTRAINT [FK_Playlists_Accounts]
GO
ALTER TABLE [dbo].[Playlists]  WITH CHECK ADD  CONSTRAINT [FK_Playlists_PlaylistTypes] FOREIGN KEY([IdPlaylistType])
REFERENCES [dbo].[PlaylistTypes] ([IdPlaylistType])
GO
ALTER TABLE [dbo].[Playlists] CHECK CONSTRAINT [FK_Playlists_PlaylistTypes]
GO
ALTER TABLE [dbo].[PlaylistTracks]  WITH CHECK ADD  CONSTRAINT [FK_PlaylistTracks_Playlists] FOREIGN KEY([IdPlaylist])
REFERENCES [dbo].[Playlists] ([IdPlaylist])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PlaylistTracks] CHECK CONSTRAINT [FK_PlaylistTracks_Playlists]
GO
ALTER TABLE [dbo].[PlaylistTracks]  WITH CHECK ADD  CONSTRAINT [FK_PlaylistTracks_Tracks] FOREIGN KEY([IdTrack])
REFERENCES [dbo].[Tracks] ([IdTrack])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PlaylistTracks] CHECK CONSTRAINT [FK_PlaylistTracks_Tracks]
GO
ALTER TABLE [dbo].[TokensUser]  WITH CHECK ADD  CONSTRAINT [FK_TokensUser_Accounts] FOREIGN KEY([IdAccount])
REFERENCES [dbo].[Accounts] ([IdAccount])
GO
ALTER TABLE [dbo].[TokensUser] CHECK CONSTRAINT [FK_TokensUser_Accounts]
GO
ALTER TABLE [dbo].[TrackCollaborators]  WITH CHECK ADD  CONSTRAINT [FK_TrackCollaborators_Artists] FOREIGN KEY([IdArtist])
REFERENCES [dbo].[Artists] ([IdArtist])
GO
ALTER TABLE [dbo].[TrackCollaborators] CHECK CONSTRAINT [FK_TrackCollaborators_Artists]
GO
ALTER TABLE [dbo].[TrackCollaborators]  WITH CHECK ADD  CONSTRAINT [FK_TrackCollaborators_Tracks] FOREIGN KEY([IdTrack])
REFERENCES [dbo].[Tracks] ([IdTrack])
GO
ALTER TABLE [dbo].[TrackCollaborators] CHECK CONSTRAINT [FK_TrackCollaborators_Tracks]
GO
/****** Object:  StoredProcedure [dbo].[SPD_DeleteAccount]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPD_DeleteAccount]
	@idAccount nvarchar(220), @estado int output, @salida nvarchar(1000) output
AS
SET @estado = 0
BEGIN TRY
	IF EXISTS (Select * from Accounts where IdAccount = @idAccount)
		BEGIN
			DELETE from Accounts where IdAccount = @idAccount
			SET @salida	= 'Exitoso'
			SET @estado = 0
		END
	ELSE
		BEGIN
			SET @salida	= 'Account does not exist'
			SET @estado = -2
		END
END TRY
BEGIN CATCH
	SET @salida = convert(varchar, ERROR_NUMBER()) + ERROR_MESSAGE()
	SET @estado = -1
	ROLLBACK TRANSACTION
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SPD_DeleteArtist]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPD_DeleteArtist]
	@idArtist NVARCHAR(220), @salida nvarchar(1000) output, @estado int output
AS
SET @estado = 0
BEGIN TRY
	BEGIN
		DELETE FROM Artists WHERE IdArtist = @idArtist
	END
END TRY
BEGIN CATCH
	SET @salida = convert(varchar, ERROR_NUMBER()) + ERROR_MESSAGE()
	SET @estado = -1
	ROLLBACK TRANSACTION
END CATCH

GO
/****** Object:  StoredProcedure [dbo].[SPD_DeletePlaylist]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPD_DeletePlaylist]
	@idPlaylist int, @salida nvarchar(1000) output, @estado int output
AS
SET @estado = 0
BEGIN TRY
	IF EXISTS (Select * from Playlists where IdPlaylist = @idPlaylist)
	BEGIN
		DELETE FROM Playlists WHERE IdPlaylist = @idPlaylist
	END
	ELSE
		SET @salida	= 'La playlist no está registrada'
END TRY
BEGIN CATCH
	SET @salida = convert(varchar, ERROR_NUMBER()) + ERROR_MESSAGE()
	SET @estado = -1
	ROLLBACK TRANSACTION
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SPD_DeleteTrack]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPD_DeleteTrack]

	@idTrack nvarchar(220), @salida nvarchar(1000) output, @estado int output
AS
SET @estado = 0
BEGIN TRY
	IF EXISTS (Select * from Tracks where IdTrack = @idTrack)
	BEGIN
		DELETE FROM Tracks WHERE IdTrack = @idTrack
	END
	ELSE
		SET @salida	= 'Track does not exist'
END TRY
BEGIN CATCH
	SET @salida = convert(varchar, ERROR_NUMBER()) + ERROR_MESSAGE()
	SET @estado = -1
	ROLLBACK TRANSACTION
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SPD_QuitTrackToPlaylist]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPD_QuitTrackToPlaylist]
	@idPlaylistTrack int, @salida nvarchar(1000) output, @estado int output
AS
SET @estado = 0
BEGIN TRY
	IF EXISTS (Select * from PlaylistTracks where IdPlaylistTrack = @idPlaylistTrack)
		BEGIN
			DELETE FROM PlaylistTracks WHERE IdPlaylistTrack = @idPlaylistTrack
		END
	ELSE
		BEGIN
			SET @salida	= 'Track no registrado en la playlist'
		END
END TRY
BEGIN CATCH
	SET @salida = convert(varchar, ERROR_NUMBER()) + ERROR_MESSAGE()
	SET @estado = -1
	ROLLBACK TRANSACTION
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SPI_AddArtistsNumberOfDate]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPI_AddArtistsNumberOfDate]
	@estado int output, @salida nvarchar(1000) output
AS
SET @estado = 0
BEGIN TRY
	DECLARE @totalArtists INT = 0
	SELECT @totalArtists = COUNT(IdArtist) FROM Artists WHERE RegisterDate = CONVERT(VARCHAR(10), GETDATE(), 111)

	INSERT INTO ArtistsNumbers
	VALUES(
		GETDATE(), @totalArtists
	);
END TRY
BEGIN CATCH
	SET @salida = convert(varchar, ERROR_NUMBER()) + ERROR_MESSAGE()
	SET @estado = -1
	ROLLBACK TRANSACTION
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SPI_AddArtistTrackReproduction]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPI_AddArtistTrackReproduction]
	@idTrack nvarchar(220),  @salida nvarchar(1000) output, @estado int output
AS
SET @estado = 0
BEGIN TRY
	DECLARE @idArtist NVARCHAR(200) 
	SELECT @idArtist = IdArtist FROM ArtistAlbumTrack WHERE IdTrack = @idTrack

	IF NOT EXISTS (SELECT * FROM ArtistsReproductions WHERE IdArtist = @idArtist)
		BEGIN
			INSERT INTO ArtistsReproductions 
			VALUES	(@idArtist,1
			);

		END
	ELSE 
		BEGIN
			UPDATE ArtistsReproductions 
			SET TotalReproductions = TotalReproductions + 1
			WHERE IdArtist = @idArtist 
		END
END TRY
BEGIN CATCH
	SET @salida = convert(varchar, ERROR_NUMBER()) + ERROR_MESSAGE()
	SET @estado = -1
	ROLLBACK TRANSACTION
END CATCH


GO
/****** Object:  StoredProcedure [dbo].[SPI_AddLikesToTracks]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPI_AddLikesToTracks]
	@estado int output, @salida nvarchar(1000) output
AS
SET @estado = 0
BEGIN TRY
	DECLARE @totaltracks INT = 0, @index INT = 1, @idTrack NVARCHAR(220), @totalLikes INT = 0
	DECLARE @tableAux TABLE(Id INT IDENTITY(1,1), IdTrack NVARCHAR(220))

	INSERT INTO @tableAux SELECT DISTINCT IdTrack FROM TracksPlaylistsLike

	SELECT @totaltracks =  COUNT(IdTrack) FROM @tableAux
	
	WHILE @index <= @totaltracks
		BEGIN
			SELECT @idTrack = IdTrack FROM @tableAux WHERE Id = @index
			SELECT @totalLikes = COUNT(IdTrack) FROM TracksPlaylistsLike WHERE IdTrack = @idTrack

			IF NOT EXISTS (SELECT * FROM TracksLikesPlaylists WHERE IdTrack = @idTrack )
				BEGIN
					INSERT INTO TracksLikesPlaylists 
					VALUES(
						@idTrack,@totalLikes
					);
				END
			ELSE
				BEGIN
					UPDATE TracksLikesPlaylists 
					SET TotalLikes = @totalLikes
					WHERE IdTrack = @idTrack
				END
			
			SET @index = @index + 1
			SET @totalLikes = 0
		END




END TRY
BEGIN CATCH
	SET @salida = convert(varchar, ERROR_NUMBER()) + ERROR_MESSAGE()
	SET @estado = -1
	ROLLBACK TRANSACTION
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SPI_AddTrackToHistory]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPI_AddTrackToHistory]
	@reproductionDate date, @idAccount nvarchar(220), @idTrack nvarchar(220),
	@salida nvarchar(1000) output, @estado int output
AS
SET @estado = 0
BEGIN TRY
	INSERT INTO History
	VALUES(
		@reproductionDate, @idAccount, @idTrack
	);
	EXEC SPI_AddArtistTrackReproduction @idTrack, null, null
END TRY
BEGIN CATCH
	SET @salida = convert(varchar, ERROR_NUMBER()) + ERROR_MESSAGE()
	SET @estado = -1
	ROLLBACK TRANSACTION
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SPI_AddTrackToPlaylist]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
		
CREATE PROCEDURE [dbo].[SPI_AddTrackToPlaylist]
	@idPlaylist int, @idTrack nvarchar(50),@salida nvarchar(1000) output, @estado int output
AS
SET @estado = 0
BEGIN TRY
	IF EXISTS (Select * from PlaylistTracks where IdPlaylist = @idPlaylist and IdTrack = @idTrack)
		BEGIN
			SET @salida	= 'Track ya registrado en la playlist'
		END
	ELSE
		BEGIN
			INSERT INTO PlaylistTracks	VALUES (@idPlaylist, @idTrack)
		END
END TRY
BEGIN CATCH
	SET @salida = convert(varchar, ERROR_NUMBER()) + ERROR_MESSAGE()
	SET @estado = -1
	ROLLBACK TRANSACTION
END CATCH

GO
/****** Object:  StoredProcedure [dbo].[SPI_CalculateDailyReproductions]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPI_CalculateDailyReproductions]
	@salida nvarchar(1000) output, @estado int output
AS
SET @estado = 0
BEGIN TRY
	DECLARE @tableAux TABLE(Id INT IDENTITY(1,1), IdTrack NVARCHAR(220))
	DECLARE @totalTracks INT, @index INT = 1, @IdTrack NVARCHAR(220), @totalTrackReproduction INT

	INSERT INTO @tableAux SELECT DISTINCT IdTrack FROM History where ReproductionDate =  CONVERT(VARCHAR(10), getdate(), 111);
	SELECT @totalTracks = COUNT(Id) FROM @tableAux

	WHILE @index <= @totalTracks
		BEGIN
			SELECT @IdTrack = IdTrack FROM @tableAux WHERE Id = @index
			SELECT @totalTrackReproduction = COUNT(IdTrack) FROM History WHERE IdTrack = @IdTrack AND ReproductionDate =  CONVERT(VARCHAR(10), getdate(), 111);

			IF EXISTS (SELECT * FROM Tracks where IdTrack = @IdTrack)
				UPDATE Tracks 
					SET Reproductions = Reproductions + @totalTrackReproduction
					WHERE IdTrack = @IdTrack

			SET @index = @index + 1
			SET @totalTrackReproduction = 0
		END


END TRY
BEGIN CATCH
	SET @salida = convert(varchar, ERROR_NUMBER()) + ERROR_MESSAGE()
	SET @estado = -1
	ROLLBACK TRANSACTION
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SPI_CreateAccount]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPI_CreateAccount]
	@IdAccount nvarchar(100), @firstName nvarchar(50),@lastName nvarchar(50),@email nvarchar(50),@password nvarchar(220),
	@userName nvarchar(50), @gender nvarchar(50), @birthday date, @cover nvarchar(50), @created datetime, @updated  datetime,
	@contentCreator bit, @typeRegister int, @salida nvarchar(1000) output, @estado int output
AS
SET @estado = 0

BEGIN TRY
	INSERT INTO Accounts 
	VALUES (
		@IdAccount, @firstName,	@lastName,
		@email,	@password,	@userName,
		@gender, @birthday,	@cover,
		@created, @updated,	@contentCreator,
		@typeRegister
	);

	INSERT INTO Playlists 
	VALUES (
		'Mis Favoritos', @created, null,0,1,@IdAccount
		);

	INSERT INTO Playlists 
	VALUES (
		'Biblioteca Personal', @created, null,0,2,@IdAccount
		);

		INSERT INTO Playlists 
	VALUES (
		'Canciones Descargadas', @created, null,0,3,@IdAccount
		);

END TRY
BEGIN CATCH
	SET @salida = convert(varchar, ERROR_NUMBER()) + ERROR_MESSAGE()
	SET @estado = -1
	ROLLBACK TRANSACTION
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SPI_CreateAlbum]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPI_CreateAlbum]
	@IdAlbum nvarchar (50), @Title nvarchar(50), @Cover nvarchar(50), @Publication date, @RecordCompany nvarchar(220),
	@IdMusicGender int, @IdAlbumType int, @IdArtist nvarchar(220), @salida nvarchar(1000) output, @estado int output
AS
SET @estado = 0
BEGIN TRY
	INSERT INTO Albums
	VALUES(
	@IdAlbum, @Title, @Cover, @Publication, @RecordCompany,
	@IdMusicGender, @IdAlbumType, @IdArtist
	);
END TRY
BEGIN CATCH
	SET @salida = convert(varchar, ERROR_NUMBER()) + ERROR_MESSAGE()
	SET @estado = -1
	ROLLBACK TRANSACTION
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SPI_CreateArtist]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPI_CreateArtist] 
	@IdArtist nvarchar (50), @Name nvarchar(50), @Cover nvarchar(50), @RegisterDate date, @Description text,
	@salida nvarchar(1000) output, @estado int output
AS
SET @estado = 0
BEGIN TRY
	INSERT INTO Artists
	VALUES(
	@IdArtist, @Name, @Cover, @RegisterDate, @Description
	);
END TRY
BEGIN CATCH
	SET @salida = convert(varchar, ERROR_NUMBER()) + ERROR_MESSAGE()
	SET @estado = -1
	ROLLBACK TRANSACTION
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SPI_CreatePlaylist]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPI_CreatePlaylist]
	@title nvarchar(50),@creation date, @cover nvarchar(50),@publicPlaylist bit, 
	@idPlaylistType int, @idAccount nvarchar(50),@salida nvarchar(1000) output, 
	@estado int output
AS
SET @estado = 0
BEGIN TRY
	INSERT INTO Playlists 
	VALUES (
		@title, @creation, @cover, @publicPlaylist, 
		@idPlaylistType, @idAccount
	)
END TRY
BEGIN CATCH
	SET @salida = convert(varchar, ERROR_NUMBER()) + ERROR_MESSAGE()
	SET @estado = -1
	ROLLBACK TRANSACTION
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SPI_CreateTrack]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPI_CreateTrack]
	@IdTrack nvarchar(220), @Title nvarchar(50),@Duration nvarchar(50),@Reproduction int,@FileTrack nvarchar(50), @avaible bit,
	@IdAlbum nvarchar(50), @salida nvarchar(1000) output, @estado int output
AS
SET @estado = 0
BEGIN TRY
	INSERT INTO Tracks
	VALUES	(
		@IdTrack,@Title,@Duration,@Reproduction,
		@FileTrack,@avaible,@IdAlbum
	)	
END TRY
BEGIN CATCH
	SET @salida = convert(varchar, ERROR_NUMBER()) + ERROR_MESSAGE()
	SET @estado = -1
	ROLLBACK TRANSACTION
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SPS_AccountExist]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPS_AccountExist]
	@idAccount nvarchar(220), @estado int output, @salida nvarchar(1000) output
AS
SET @estado = 0
BEGIN
	IF EXISTS (Select * from Accounts where IdAccount = @idAccount)
		BEGIN
			SET @salida	= 'Exitoso'
			SET @estado = 0
		END
	ELSE
		BEGIN
			SET @salida	= 'Account does not exist'
			SET @estado = -1
		END
END
GO
/****** Object:  StoredProcedure [dbo].[SPS_AlbumExists]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPS_AlbumExists]
	@IdAlbum nvarchar(220), @estado int output, @salida nvarchar(1000) output
AS
SET @estado = 0
BEGIN
	IF EXISTS (Select * from  Albums where IdAlbum = @IdAlbum)
		BEGIN
			SET @salida	= 'Successfully'
			SET @estado = 0
		END
	ELSE
		BEGIN
			SET @salida	= 'Album does not exist'
			SET @estado = -1
		END
END


GO
/****** Object:  StoredProcedure [dbo].[SPS_AlbumGenderExists]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPS_AlbumGenderExists]
	@idMusicGender int, @estado int output, @salida nvarchar(1000) output
AS
SET @estado = 0
BEGIN
	IF EXISTS (Select * from MusicGenders where IdMusicGender = @idMusicGender)
		BEGIN
			SET @salida	= 'successful'
			SET @estado = 0
		END
	ELSE
		BEGIN
			SET @salida	= 'Music gender not exists'
			SET @estado = -1
		END
END

GO
/****** Object:  StoredProcedure [dbo].[SPS_AlbumTypeExist]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPS_AlbumTypeExist]
	@idAlbumType int, @estado int output, @salida nvarchar(1000) output
AS
SET @estado = 0
BEGIN
	IF EXISTS (Select * from AlbumTypes where IdAlbumType = @idAlbumType)
		BEGIN
			SET @salida	= 'successful'
			SET @estado = 0
		END
	ELSE
		BEGIN
			SET @salida	= 'Album type not exists'
			SET @estado = -1
		END
END

GO
/****** Object:  StoredProcedure [dbo].[SPS_ArtistExist]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPS_ArtistExist] 
	@IdArtist nvarchar(50), 
	@estado int output, @salida nvarchar(50) output 
AS
SET @estado = 0
BEGIN
	IF EXISTS (SELECT * FROM Artists WHERE IdArtist = @IdArtist)
		BEGIN
			SET @salida = 'Existoso'
			SET @estado = 0;
		END
	ELSE
		BEGIN
			SET @salida = 'El artista no está registrado'
			SET @estado = -1
		END
END
GO
/****** Object:  StoredProcedure [dbo].[SPS_EmailExist]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPS_EmailExist]
	@email nvarchar(220), @estado int output, @salida nvarchar(1000) output
AS
SET @estado = 0
BEGIN
	IF EXISTS (Select * from Accounts where Email = @email)
		BEGIN
			SET @salida	= 'Exitoso'
			SET @estado = 0
		END
	ELSE
		BEGIN
			SET @salida	= 'Account does not exist'
			SET @estado = -1
		END
END
GO
/****** Object:  StoredProcedure [dbo].[SPS_GetAlbumById]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPS_GetAlbumById]
	@idAlbum nvarchar(220), @estado int output, @salida nvarchar(1000) output
AS
SET @estado = 0
BEGIN TRY
	IF EXISTS (Select * from Albums where IdAlbum = @idAlbum)
		BEGIN
			Select * from Albums where IdAlbum = @idAlbum
			SET @salida	= 'successful'
			SET @estado = 0
		END
	ELSE
		BEGIN
			SET @salida	= 'Album does not exist'
			SET @estado = -2
		END
END TRY
BEGIN CATCH
	SET @salida = convert(varchar, ERROR_NUMBER()) + ERROR_MESSAGE()
	SET @estado = -1
	ROLLBACK TRANSACTION
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SPS_GetAlbumsLikeOfAccount]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPS_GetAlbumsLikeOfAccount]
	@idAccount nvarchar(220), @estado int output, @salida nvarchar(1000) output
AS
SET @estado = 0
BEGIN TRY
	IF EXISTS (Select * from Accounts where IdAccount = @idAccount)
		BEGIN
			DECLARE @TableAux TABLE(IdAlbum NVARCHAR(220), Cover NVARCHAR(220),Publication DATE, RecordCompany NVARCHAR(220), IdMusicGender INT, IdAlbumType INT, IdArtist NVARCHAR(220), Title NVARCHAR(220))

			
			INSERT INTO @TableAux
			SELECT Albums.IdAlbum, Albums.Cover, Albums.Publication, Albums.RecordCompany, Albums.IdMusicGender, Albums.IdAlbumType, Albums.IdArtist, Albums.Title
			FROM dbo.Playlists P 
			INNER JOIN PlaylistTracks ON P.IdPlaylist = PlaylistTracks.IdPlaylist
			INNER JOIN Tracks ON PlaylistTracks.IdTrack = Tracks.IdTrack 
			INNER JOIN  Albums ON Tracks.IdAlbum = Albums.IdAlbum
			WHERE (P.IdAccount = @idAccount) AND (P.IdPlaylistType = 1)

			SELECT IdAlbum, Cover, Publication, RecordCompany,IdMusicGender, IdAlbumType, IdArtist, Title FROM @TableAux ORDER BY Title
			SET @salida	= 'successful'
			SET @estado = 0
		END
	ELSE
		BEGIN
			SET @salida	= 'Account does not exist'
			SET @estado = -2
		END
END TRY
BEGIN CATCH
	SET @salida = convert(varchar, ERROR_NUMBER()) + ERROR_MESSAGE()
	SET @estado = -1
	ROLLBACK TRANSACTION
END CATCH

GO
/****** Object:  StoredProcedure [dbo].[SPS_GetAlbumsOfArtist]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPS_GetAlbumsOfArtist] 
	@idArtist nvarchar(220), @estado int output, @salida nvarchar(1000) output
AS
SET @estado = 0
BEGIN TRY
	IF EXISTS (Select * from Artists where IdArtist = @idArtist)
		BEGIN
			Select Al.IdAlbum, Al.Title, Al.Cover, Al.Publication, Al.RecordCompany, M.GenderName, Al.IdAlbumType, Al.IdArtist, Ar.Name as ArtistName
			FROM Albums Al 
			INNER JOIN MusicGenders M ON M.IdMusicGender = Al.IdMusicGender
			INNER JOIN Artists Ar ON Al.IdArtist = Ar.IdArtist
			where Al.IdArtist = @idArtist
			SET @salida	= 'successful'
			SET @estado = 0
		END
	ELSE
		BEGIN
			SET @salida	= 'Artist does not exist'
			SET @estado = -2
		END
END TRY
BEGIN CATCH
	SET @salida = convert(varchar, ERROR_NUMBER()) + ERROR_MESSAGE()
	SET @estado = -1
	ROLLBACK TRANSACTION
END CATCH


GO
/****** Object:  StoredProcedure [dbo].[SPS_GetArtistAlbumsLikeOfAccount]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPS_GetArtistAlbumsLikeOfAccount]
	@idAccount nvarchar(220), @idArtist nvarchar(220), @estado int output, @salida nvarchar(1000) output
AS
SET @estado = 0
BEGIN TRY
	IF EXISTS (Select * from Accounts where IdAccount = @idAccount)
		BEGIN
			DECLARE @TableAux TABLE(IdAlbum NVARCHAR(220), Cover NVARCHAR(220),Publication DATE, RecordCompany NVARCHAR(220), IdMusicGender INT, IdAlbumType INT, IdArtist NVARCHAR(220), Title NVARCHAR(220))

			INSERT INTO @TableAux
			SELECT Albums.IdAlbum, Albums.Cover, Albums.Publication, Albums.RecordCompany, Albums.IdMusicGender, Albums.IdAlbumType, Albums.IdArtist, Albums.Title
			FROM dbo.Playlists P 
			INNER JOIN PlaylistTracks ON P.IdPlaylist = PlaylistTracks.IdPlaylist
			INNER JOIN Tracks ON PlaylistTracks.IdTrack = Tracks.IdTrack 
			INNER JOIN  Albums ON Tracks.IdAlbum = Albums.IdAlbum
			WHERE (P.IdAccount = @idAccount) AND (P.IdPlaylistType = 1) AND (Albums.IdArtist = @idArtist)

			SELECT IdAlbum, Cover, Publication, RecordCompany,IdMusicGender, IdAlbumType, IdArtist, Title FROM @TableAux ORDER BY Title
			SET @salida	= 'successful'
			SET @estado = 0
		END
	ELSE
		BEGIN
			SET @salida	= 'Account does not exist'
			SET @estado = -2
		END
END TRY
BEGIN CATCH
	SET @salida = convert(varchar, ERROR_NUMBER()) + ERROR_MESSAGE()
	SET @estado = -1
	ROLLBACK TRANSACTION
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SPS_GetArtistsLikeOfAccount]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPS_GetArtistsLikeOfAccount]
	@idAccount nvarchar(220), @estado int output, @salida nvarchar(1000) output
AS
SET @estado = 0
BEGIN TRY
	IF EXISTS (Select * from Accounts where IdAccount = @idAccount)
		BEGIN
			DECLARE @TableAux TABLE(IdArtist NVARCHAR(220),Name NVARCHAR(220), Description NVARCHAR(220), Cover NVARCHAR(220), RegisterDate DATE)
 
			INSERT INTO @TableAux
			SELECT A.IdArtist, A.Name, A.Description, A.Cover, A.RegisterDate
			FROM dbo.Playlists P 
			INNER JOIN PlaylistTracks ON P.IdPlaylist = PlaylistTracks.IdPlaylist
			INNER JOIN Tracks ON PlaylistTracks.IdTrack = Tracks.IdTrack 
			INNER JOIN  Albums ON Tracks.IdAlbum = Albums.IdAlbum 
			INNER JOIN Artists A ON A.IdArtist = Albums.IdArtist
			WHERE (P.IdAccount = @idAccount ) AND (P.IdPlaylistType = 1)

			SELECT DISTINCT IdArtist, Name, Description, Cover, RegisterDate FROM @TableAux ORDER BY Name

			SET @salida	= 'successful'
			SET @estado = 0
		END
	ELSE
		BEGIN
			SET @salida	= 'Account does not exist'
			SET @estado = -2
		END
END TRY
BEGIN CATCH
	SET @salida = convert(varchar, ERROR_NUMBER()) + ERROR_MESSAGE()
	SET @estado = -1
	ROLLBACK TRANSACTION
END CATCH


GO
/****** Object:  StoredProcedure [dbo].[SPS_GetArtistWithAlbumsTracks]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPS_GetArtistWithAlbumsTracks] 
	@idArtist nvarchar(50), @Salida nvarchar(50) output, @Estado int output
AS
SET @Estado = 0
BEGIN
	EXEC SPS_ArtistExist @idArtist, @Estado, @Salida
	SELECT
	Name, Album_Title, Cover, Track_Title, Duration, FileTrack 
	FROM ArtistAlbumTrack 
	WHERE IdArtist = @idArtist ORDER BY Album_Title
END
GO
/****** Object:  StoredProcedure [dbo].[SPS_GetPlaylistsOfAccount]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPS_GetPlaylistsOfAccount]
	@idAccount nvarchar(50)
AS
BEGIN
	Select
	P.IdPlaylist,
	P.Title,
	P.Creation,
	P.Cover,
	P.PublicPlaylist,
	P.IdPlaylistType,
	P.IdAccount,
	A.UserName
	from Playlists P
	INNER JOIN Accounts A ON A.IdAccount = P.IdAccount
	where P.IdAccount = @idAccount
END
GO
/****** Object:  StoredProcedure [dbo].[SPS_GetTrackById]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPS_GetTrackById]
	@idTrack nvarchar(220), @estado int output, @salida nvarchar(1000) output
AS
SET @estado = 0
BEGIN TRY
	IF EXISTS (Select * from Tracks where IdTrack = @idTrack)
		BEGIN
			Select * from Tracks where @idTrack = IdTrack
			SET @salida	= 'successful'
			SET @estado = 0
		END
	ELSE
		BEGIN
			SET @salida	= 'Track does not exist'
			SET @estado = -2
		END
END TRY
BEGIN CATCH
	SET @salida = convert(varchar, ERROR_NUMBER()) + ERROR_MESSAGE()
	SET @estado = -1
	ROLLBACK TRANSACTION
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SPS_GetTracksArtistById]    Script Date: 10/07/2020 04:02:46 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPS_GetTracksArtistById]
	@IdArtist  nvarchar(50), @Estado int output, @Salida nvarchar(50) output
AS
SET @Estado = 0
BEGIN
	IF EXISTS(SELECT * FROM Artists WHERE IdArtist = @IdArtist)
		SELECT 
		Cover, Name, Title, Duration, Avaible, FileTrack, AlbumCover
		FROM TracksArtist WHERE IdArtist = @IdArtist ORDER BY Name
END
GO
/****** Object:  StoredProcedure [dbo].[SPS_GetTracksOfAlbum]    Script Date: 10/07/2020 04:02:47 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPS_GetTracksOfAlbum]
	@idAlbum nvarchar(220), @Salida nvarchar(50) output, @Estado int output
AS
SET @Estado = 0
BEGIN
	EXEC SPS_AlbumExists @idAlbum, @Estado, @Salida
	SELECT
	IdTrack, Title, Duration, Reproductions, Duration, FileTrack,  Avaible 
	FROM Tracks 
	WHERE IdAlbum = @idAlbum ORDER BY Title
END

GO
/****** Object:  StoredProcedure [dbo].[SPS_GetTracksOfPlaylist]    Script Date: 10/07/2020 04:02:47 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPS_GetTracksOfPlaylist]
	@idTrack int
AS
BEGIN
	Select 
	PT.IdPlaylistTrack,
	PT.IdPlaylist,
	PT.IdTrack,
	AAT.Track_Title as 'TitleTrack',
	AAT.Duration,
	AAT.FileTrack,
	AAT.Avaible,
	AAT.IdAlbum,
	AAT.Album_Title as 'TitleAlbum',
	AAT.Cover,
	AAT.IdArtist,
	AAT.Name as 'NameArtist'
	from PlaylistTracks PT
	INNER JOIN ArtistAlbumTrack AAT ON AAT.IdTrack = PT.IdTrack
	WHERE PT.IdPlaylist = @idTrack
END
GO
/****** Object:  StoredProcedure [dbo].[SPS_LoginWithEmail]    Script Date: 10/07/2020 04:02:47 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPS_LoginWithEmail]
	@email nvarchar(110), @password NVARCHAR(256),
	@estado int output, @salida nvarchar(50) output 
AS
SET @estado = 0
BEGIN
	IF EXISTS (SELECT * FROM Accounts WHERE Email = @email)
		BEGIN
		SELECT IdAccount,FirstName,LastName,Email,UserName,Gender,Birthday,Cover,CreatedDate, UpdatedDate,ContentCreator FROM Accounts where Email = @email and Password = @password
			SET @salida = 'Successful'
			SET @estado = 0;
		END
	ELSE
		BEGIN
			SET @salida = 'Email not exists'
			SET @estado = -1
		END
END

GO
/****** Object:  StoredProcedure [dbo].[SPS_LoginWithUsername]    Script Date: 10/07/2020 04:02:47 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,>
-- =============================================
CREATE PROCEDURE [dbo].[SPS_LoginWithUsername]
	@username nvarchar(50), @password NVARCHAR(256),
	@estado int output, @salida nvarchar(50) output 
AS
SET @estado = 0
BEGIN
	IF EXISTS (SELECT * FROM Accounts WHERE UserName = @username)
		BEGIN
		SELECT IdAccount,FirstName,LastName,Email,UserName,Gender,Birthday,Cover,CreatedDate, UpdatedDate,ContentCreator FROM Accounts where UserName = @username and Password = @password
			SET @salida = 'Existoso'
			SET @estado = 0;
		END
	ELSE
		BEGIN
			SET @salida = 'Account not exists'
			SET @estado = -1
		END
END
GO
/****** Object:  StoredProcedure [dbo].[SPS_PlaylistExist]    Script Date: 10/07/2020 04:02:47 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPS_PlaylistExist]
	@idPlaylist int, @estado int output, @salida nvarchar(1000) output
AS
SET @estado = 0
BEGIN
	IF EXISTS (Select * from Playlists where IdPlaylist = @idPlaylist)
		BEGIN
			SET @salida	= 'Exitoso'
			SET @estado = 0
		END
	ELSE
		BEGIN
			SET @salida	= 'Playlist does not exist'
			SET @estado = -1
		END
END

GO
/****** Object:  StoredProcedure [dbo].[SPS_TrackExistInPlaylist]    Script Date: 10/07/2020 04:02:47 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPS_TrackExistInPlaylist]
	@idTrack nvarchar(220), @idPlaylist int, @estado int output, @salida nvarchar(1000) output
AS
SET @estado = 0
BEGIN
	IF EXISTS (Select * from PlaylistTracks where IdPlaylist = @idPlaylist and IdTrack = @idTrack)
		BEGIN
			SET @salida	= 'Exitoso'
			SET @estado = 0
		END
	ELSE
		BEGIN
			SET @salida	= 'Track does not exist in playlist'
			SET @estado = -1
		END
END

GO
/****** Object:  StoredProcedure [dbo].[SPS_TrackExists]    Script Date: 10/07/2020 04:02:47 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPS_TrackExists] 
	@IdTrack nvarchar(220), @estado int output, @salida nvarchar(1000) output
AS
SET @estado = 0
BEGIN
	IF EXISTS (Select * from  Tracks where IdTrack = @IdTrack)
		BEGIN
			SET @salida	= 'Successfully'
			SET @estado = 0
		END
	ELSE
		BEGIN
			SET @salida	= 'Album does not exist'
			SET @estado = -1
		END
END


GO
/****** Object:  StoredProcedure [dbo].[SPS_UserNameExist]    Script Date: 10/07/2020 04:02:47 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPS_UserNameExist]
	@userName nvarchar(220), @estado int output, @salida nvarchar(1000) output
AS
SET @estado = 0
BEGIN
	IF EXISTS (Select * from Accounts where UserName = @userName)
		BEGIN
			SET @salida	= 'Exitoso'
			SET @estado = 0
		END
	ELSE
		BEGIN
			SET @salida	= 'Account does not exist'
			SET @estado = -1
		END
END
GO
/****** Object:  StoredProcedure [dbo].[SPU_UpdateAccount]    Script Date: 10/07/2020 04:02:47 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SPU_UpdateAccount]
	@idAccount nvarchar(220), @firstName nvarchar(50), @lastName nvarchar(50), @userName nvarchar(50),
	@birthday date, @cover nvarchar(100), @updated datetime,  @salida nvarchar(1000) output, @estado int output
AS
SET @estado = 0
BEGIN TRY
	IF EXISTS (Select * from Accounts where IdAccount = @idAccount)
	BEGIN
		UPDATE Accounts
		SET FirstName = ISNULL(@firstName,FirstName),
		LastName = ISNULL(@lastName,LastName),
		UserName = ISNULL(@userName,UserName),
		Birthday = ISNULL(@birthday,Birthday),
		Cover =ISNULL(@cover,Cover),
		UpdatedDate = ISNULL(@updated,UpdatedDate)
		WHERE IdAccount = @idAccount
	END
	ELSE
		SET @salida	= 'La cuenta no está registrada'	
END TRY
BEGIN CATCH
	SET @salida = convert(varchar, ERROR_NUMBER()) + ERROR_MESSAGE()
	SET @estado = -1
	ROLLBACK TRANSACTION
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SPU_UpdateArtist]    Script Date: 10/07/2020 04:02:47 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPU_UpdateArtist] 
	@IdArtist nvarchar (50), @Name nvarchar(50), @Cover nvarchar(50), @Description text,
	@salida nvarchar(1000) output, @estado int output
AS
SET @salida = 0
BEGIN TRY
	IF EXISTS (SELECT *FROM Artists WHERE IdArtist = @IdArtist)
	BEGIN
		UPDATE Artists
		SET Name = ISNULL(@Name, Name),
		Cover = ISNULL(@Cover, Cover),
		Description = ISNULL(@Description, Description)
		WHERE IdArtist = @IdArtist
	END
	ELSE
		SET @salida = 'El Artista no está registrado'	
END TRY
BEGIN CATCH
	SET @salida = convert(varchar, ERROR_NUMBER()) + ERROR_MESSAGE()
	SET @estado = -1
	ROLLBACK TRANSACTION
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SPU_UpdatePlaylist]    Script Date: 10/07/2020 04:02:47 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPU_UpdatePlaylist]
	@idPlaylist int, @title nvarchar(50), @cover nvarchar(50), @publicPlaylist bit,
	@salida nvarchar(1000) output, @estado int output
AS
SET @estado = 0
BEGIN TRY
	IF EXISTS (Select * from Playlists where IdPlaylist = @idPlaylist)
	BEGIN
		UPDATE Playlists
		SET Title = ISNULL(@title,Title),
		Cover = ISNULL(@cover,Cover),
		PublicPlaylist = ISNULL(@publicPlaylist,PublicPlaylist)
		WHERE IdPlaylist = @idPlaylist
	END
	ELSE
		SET @salida	= 'La playlist no está registrada'
END TRY
BEGIN CATCH
	SET @salida = convert(varchar, ERROR_NUMBER()) + ERROR_MESSAGE()
	SET @estado = -1
	ROLLBACK TRANSACTION
END CATCH
GO
/****** Object:  StoredProcedure [dbo].[SPU_UpdateTrack]    Script Date: 10/07/2020 04:02:47 a. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SPU_UpdateTrack] 
	@idTrack nvarchar(220), @title nvarchar(50), @duration int, @reproductions int,
	@fileTrack nvarchar(100), @avaible bit, @idAlbum nvarchar(220),  @salida nvarchar(1000) output, @estado int output
AS
SET @estado = 0
BEGIN TRY
	IF EXISTS (Select * from Tracks where IdTrack = @IdTrack)
	BEGIN
		UPDATE Tracks
		SET Title = ISNULL(@title,Title),
		Duration = ISNULL(@duration,Duration),
		Reproductions = ISNULL(@reproductions,Reproductions),
		FileTrack =ISNULL(@fileTrack,FileTrack),
		Avaible = ISNULL(@avaible,Avaible),
		IdAlbum = ISNULL(@idAlbum, IdAlbum)
		WHERE Idtrack = @idTrack
	END
	ELSE
		SET @salida	= 'Track does not exist'	
END TRY
BEGIN CATCH
	SET @salida = convert(varchar, ERROR_NUMBER()) + ERROR_MESSAGE()
	SET @estado = -1
	ROLLBACK TRANSACTION
END CATCH



GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Albums"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 216
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Artists"
            Begin Extent = 
               Top = 132
               Left = 239
               Bottom = 262
               Right = 409
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Tracks"
            Begin Extent = 
               Top = 0
               Left = 588
               Bottom = 130
               Right = 780
            End
            DisplayFlags = 280
            TopColumn = 3
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ArtistAlbumTrack'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ArtistAlbumTrack'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[41] 4[21] 2[6] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Artists"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "History"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 431
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tracks"
            Begin Extent = 
               Top = 6
               Left = 469
               Bottom = 136
               Right = 639
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Albums"
            Begin Extent = 
               Top = 103
               Left = 577
               Bottom = 233
               Right = 755
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ArtistsHistoryTracks'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ArtistsHistoryTracks'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'ArtistsHistoryTracks'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Albums"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 216
            End
            DisplayFlags = 280
            TopColumn = 4
         End
         Begin Table = "MusicGenders"
            Begin Extent = 
               Top = 167
               Left = 263
               Bottom = 280
               Right = 433
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Tracks"
            Begin Extent = 
               Top = 6
               Left = 462
               Bottom = 136
               Right = 654
            End
            DisplayFlags = 280
            TopColumn = 3
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'MusicGendersTracksAlbum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'MusicGendersTracksAlbum'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Artists"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 1
         End
         Begin Table = "Albums"
            Begin Extent = 
               Top = 6
               Left = 454
               Bottom = 136
               Right = 632
            End
            DisplayFlags = 280
            TopColumn = 2
         End
         Begin Table = "Tracks"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 136
               Right = 416
            End
            DisplayFlags = 280
            TopColumn = 3
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TracksArtist'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TracksArtist'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[31] 4[32] 2[5] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = -191
      End
      Begin Tables = 
         Begin Table = "PlaylistTracks"
            Begin Extent = 
               Top = 6
               Left = 480
               Bottom = 119
               Right = 650
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Playlists"
            Begin Extent = 
               Top = 6
               Left = 272
               Bottom = 136
               Right = 442
            End
            DisplayFlags = 280
            TopColumn = 3
         End
         Begin Table = "Tracks"
            Begin Extent = 
               Top = 6
               Left = 688
               Bottom = 136
               Right = 858
            End
            DisplayFlags = 280
            TopColumn = 3
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TracksPlaylistsLike'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'TracksPlaylistsLike'
GO

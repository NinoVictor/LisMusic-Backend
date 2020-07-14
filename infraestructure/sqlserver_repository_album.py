from albums.albums.domain.album import Album
from albums.albums.application.repositories.repository_album import AlbumRepository
from infraestructure.connection import ConnectionSQL
from albums.albums.domain.exceptions import DataBaseException, AlbumNotExistsException

from flask import jsonify
import json
from tracks.tracks.domain.track import Track

class SqlServerAlbumRepository(AlbumRepository):
    def __init__(self):
        self.connection = ConnectionSQL()

    def save(self, album: Album):
        self.connection.open()
        sql = """
                DECLARE	@return_value int,
                @salida nvarchar(1000),
                @estado int

        EXEC	@return_value = [dbo].[SPI_CreateAlbum]
                @IdAlbum = ?,
                @Title = ?,
                @Cover = ?,
                @Publication = ?,
                @RecordCompany = ?,
                @IdMusicGender = ?,
                @IdAlbumType = ?,
                @IdArtist = ?,
                @salida = @salida OUTPUT,
                @estado = @estado OUTPUT

        SELECT	@salida as N'@salida',
                @estado as N'@estado'
        """
       
        params = (album.idAlbum,album.title,album.cover,album.publication,album.recordCompany,
                album.idMusicGender,album.idAlbumType,album.idArtist)
        print(album.idMusicGender)
        self.connection.cursor.execute(sql,params)

        try:
            self.connection.save()
            print(self.connection.cursor.rowcount, "Album created")
            self.connection.close()
            return True
        except DataBaseException as ex:
            raise DataBaseException("Database error")

    def exists_album_gender(self, idAlbumGender:str):
        self.connection.open()

        sql = """\
            DECLARE	@return_value int,
                    @estado int,
                    @salida nvarchar(1000)

            EXEC	@return_value = [dbo].[SPS_AlbumGenderExists]
                    @idMusicGender = ?,
                    @estado = @estado OUTPUT,
                    @salida = @salida OUTPUT

            SELECT	@estado as N'@estado',
                    @salida as N'@salida'
        """
        self.connection.cursor.execute(sql, idAlbumGender)
        row = self.connection.cursor.fetchval()
        result = False
        if row == -1:
            result = False
        else:
            result = True
            
        self.connection.close()
        return result

    def exists_album_type(self, idAlbumType:str):
        self.connection.open()
        sql = """\
            DECLARE	@return_value int,
                    @estado int,
                    @salida nvarchar(1000)

            EXEC	@return_value = [dbo].[SPS_AlbumTypeExist]
                    @idAlbumType = ?,
                    @estado = @estado OUTPUT,
                    @salida = @salida OUTPUT

            SELECT	@estado as N'@estado',
                    @salida as N'@salida'
        """
        self.connection.cursor.execute(sql, idAlbumType)
        row = self.connection.cursor.fetchval()
        result = False
        if row == -1:
            result = False
        else:
            result = True
            
        self.connection.close()
        return result

    def exists_album(self, idAlbum:str):
        self.connection.open()
        sql = """\
            DECLARE	@return_value int,
                    @estado int,
                    @salida nvarchar(1000)

            EXEC	@return_value = [dbo].[SPS_AlbumExists]
                    @IdAlbum = ?,
                    @estado = @estado OUTPUT,
                    @salida = @salida OUTPUT

            SELECT	@estado as N'@estado',
                    @salida as N'@salida'
        """
        self.connection.cursor.execute(sql, idAlbum)
        row = self.connection.cursor.fetchval()
        result = False
        if row == -1:
            result = False
        else:
            result = True
            
        self.connection.close()
        return result

    def get_albums_of_artist(self, idArtist:str):
        self.connection.open()
        sql = """\
            DECLARE	@return_value int,
                    @estado int,
                    @salida nvarchar(1000)

            EXEC	@return_value = [dbo].[SPS_GetAlbumsOfArtist]
                    @IdArtist = ?,
                    @estado = @estado OUTPUT,
                    @salida = @salida OUTPUT

            SELECT	@estado as N'@estado',
                    @salida as N'@salida'
        """
        self.connection.cursor.execute(sql, idArtist)
        rows = self.connection.cursor.fetchall()
        list_albums = []
        for row in rows:
            album = Album(row.IdAlbum,row.Title,row.Cover,row.Publication.strftime('%Y-%m-%d'), row.RecordCompany,
                            row.GenderName, row.IdAlbumType)
            album.artist.idArtist = row.IdArtist
            album.artist.name = row.ArtistName
            list_albums.append(album)

        return list_albums

    def get_tracks_of_album(self, idAlbum:str):
            self.connection.open()
            sql = """\
            DECLARE	@return_value int,
                    @estado int,
                    @salida nvarchar(1000)

            EXEC    @return_value = [dbo].[SPS_GetTracksOfAlbum]
                    @idAlbum = ?,
                    @estado = @estado OUTPUT,
                    @salida = @salida OUTPUT

            SELECT	@estado as N'@estado',
                    @salida as N'@salida'
            """

            self.connection.cursor.execute(sql, idAlbum)

            list_tracks = []
            rows = self.connection.cursor.fetchall()
            for row in rows:
                print(row)
                track = Track(row.IdTrack,row.Title,row.Duration,row.Reproductions,row.FileTrack,row.Avaible)
                list_tracks.append(track)
                
            
            return list_tracks     


    def get_albums_like_of_account(self, idAccount: str):
        sql = """\
        SET NOCOUNT ON;    
        DECLARE	@return_value int,
                @estado int,
                @salida nvarchar(1000)
         EXEC    @return_value = [dbo].[SPS_GetAlbumsLikeOfAccount]
                @idAccount = ?,
                @estado = @estado OUTPUT,
                @salida = @salida OUTPUT

        SELECT	@estado as N'@estado',
                @salida as N'@salida'
        """
        try:
            self.connection.open()
            self.connection.cursor.execute(sql,idAccount)
            pass
        except DataBaseException as ex:
            raise ("Database connection error")
        rows = self.connection.cursor.fetchall()
        list_albums = []
        for row in rows:
            album = Album(row.IdAlbum,row.Title,row.Cover,row.Publication.strftime('%Y-%m-%d'), row.RecordCompany,
                            row.IdMusicGender, row.IdAlbumType, row.ArtistName, row.GenderName)
            list_albums.append(album)

        return list_albums
            
    def update(self, album: Album):
        pass
        

    def delete(self, idAlbum: str):
        pass

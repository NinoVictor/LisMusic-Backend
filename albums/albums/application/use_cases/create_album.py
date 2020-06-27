from albums.albums.application.repositories.repository_album import AlbumRepository
from albums.albums.domain.exceptions import AlbumGenderInvalidException, AlbumInvalidException, AlbumTypeInvalidException, DataBaseException, AlbumTracksInvalidException
from infraestructure.sqlserver_repository_artist import SqlServerArtistRepository
from dataclasses import dataclass
from albums.albums.domain.album import Album
import datetime
from tracks.tracks.domain.track import Track
from artists.artists.application.use_cases import exists_artist

@dataclass
class CreateAlbumInputDto:
    title: str = None
    cover: str = None
    publication: datetime.date = None
    recordCompany: str = None 
    idMusicGender: int = None  
    idAlbumType: int = None
    idArtist: str = None 
    tracks: str = None

class CreateAlbum:
    def __init__(self, repository: AlbumRepository):
        self.repository = repository

    def execute(self, inputAlbum: CreateAlbumInputDto):
        print(inputAlbum.idMusicGender)

        if not inputAlbum.title or not inputAlbum.recordCompany or not inputAlbum.idAlbumType or not inputAlbum.idAlbumType or not inputAlbum.idArtist:
            raise AlbumInvalidException("Empty fields")

        if not self.repository.exists_album_gender(inputAlbum.idMusicGender):
            raise AlbumGenderInvalidException("Album gender not exists")

        if not self.repository.exists_album_type(inputAlbum.idAlbumType):
            raise AlbumTypeInvalidException("Album type not exists")

        usecase_exists_artist = exists_artist.ExistsArtist(SqlServerArtistRepository())
        dtoclass = exists_artist.ExistsArtistInputDto(inputAlbum.idArtist)
        usecase_exists_artist.execute(dtoclass)

        if not inputAlbum.tracks:
            raise AlbumTracksInvalidException("Album tracks not found")

        new_album = Album.create(inputAlbum.title, inputAlbum.cover, inputAlbum.publication,
        inputAlbum.recordCompany,inputAlbum.idMusicGender, inputAlbum.idAlbumType,inputAlbum.idArtist)

        try:
            self.repository.save(new_album)
            return new_album
        except DataBaseException:
            raise DataBaseException("Database error")
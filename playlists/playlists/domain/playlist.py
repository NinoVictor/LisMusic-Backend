from playlists.playlists.domain.exceptions import InvalidPlaylistException
from accounts.accounts.domain.account import Account
import datetime 

class Playlist:
    def __init__(self, idPlaylist=None, title=None, creation=None, cover=None, publicPlaylist=None,
                    idPlaylistType=None):
        self.idPlaylist: int = idPlaylist
        self.title: str = title
        self.creation: datetime.date = creation
        self.cover: str = cover
        self.publicPlaylist: bool = publicPlaylist
        self.idPlaylistType: int = idPlaylistType
        self.account:Account = Account()

    @classmethod
    def create(cls, title, cover, publicPlaylist, idPlaylistType, idAccount):
        if not title or not idAccount or not idPlaylistType:
            raise InvalidPlaylistException("Missing fields")

        if not cover:
            cover = "defaultPlaylistCover.jpg"

        newPlaylist = Playlist(None, title, datetime.datetime.now(),cover,publicPlaylist, idPlaylistType)

        return newPlaylist

    def to_json(self):
        playlist_to_json = {
            "idPlaylist":self.idPlaylist,
            "title":self.title,
            "creation": str(self.creation),
            "cover": 'http://10.0.2.2:6000/media/playlists/{}'.format(self.cover),
            "publicPlaylist":self.publicPlaylist,
            "idPlaylistType":self.idPlaylistType,
            "idAccount": 'http://10.0.2.2:6000/account/{}'.format(self.account.idAccount),
            "owner":self.account.userName
        }
        return playlist_to_json

    def to_json_create(self):
        playlist_to_json = {
            "title":self.title,
            "creation": str(self.creation),
            "cover": 'http://10.0.2.2:6000/media/playlists/{}'.format(self.cover),
            "publicPlaylist":self.publicPlaylist,
            "idPlaylistType":self.idPlaylistType,
            "idAccount": 'http://10.0.2.2:6000/account/{}'.format(self.account.idAccount),  
        }
        
        return playlist_to_json
        

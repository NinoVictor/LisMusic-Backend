import os

basedir = os.path.abspath(os.path.dirname(__file__))

BASE_DIR = os.path.abspath(os.path.dirname(__file__))
# Media dir
MEDIA_DIR = os.path.join(BASE_DIR, 'media')
ALBUMS_DIR = os.path.join(MEDIA_DIR, 'albums')
PLAYLISTS_DIR = os.path.join(MEDIA_DIR, 'playlists')

DATABASE_SERVER_IP = '25.111.36.180'
DATABASE_NAME = 'LisMusicDB'
DATABASE_USERNAME = 'sa'
DATABASE_PASSWORD = '12345'
SECRET_KEY = "0261ee2581464bc5b37adb77608c5b2e"
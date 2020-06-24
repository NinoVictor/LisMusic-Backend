import pyodbc
from accounts.accounts.domain.exceptions import DataBaseException

class ConnectionSQL:
    def __init__(self):
        self.connection = None
        self.cursor = None
        self.server = 'localhost,1500'
        self.database = 'LisMusicDB'
        self.username = 'usrLisMusicDB'
        self.password = 'usrLisMusicDB_2020'
        self.connectionString = "DRIVER={ODBC Driver 17 for SQL Server}" + ";SERVER={0};DATABASE={1};UID={2};PWD={3}".format(
        self.server, self.database,self.username,self.password)
        

    def open(self):
        try:
            self.connection = pyodbc.connect(self.connectionString)
        except Exception as ex:
            raise DataBaseException(ex)
        self.cursor = self.connection.cursor()


    def close(self):
        self.cursor.close()
        self.connection.close()

    def save(self):
        self.connection.commit()
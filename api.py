from flask import Flask, session, request, g
import datetime
import decimal
from flask_restful import Resource, Api, reqparse
from flaskext.mysql import MySQL
from passlib.apps import custom_app_context as pwd_context
from flask_httpauth import HTTPBasicAuth
import configparser
import sys

def hash_password(password):
    return pwd_context.encrypt(password)

def verifyPassword(password, pwdHash):
    return pwd_context.verify(password, pwdHash)

app = Flask(__name__)
auth = HTTPBasicAuth()
api = Api(app)
mysql = MySQL()

#Read credentials from config.ini
config = configparser.ConfigParser()
config.read("config.ini")

app.config['MYSQL_DATABASE_USER'] = config['credentials']['user']
app.config['MYSQL_DATABASE_PASSWORD'] = config['credentials']['pass']
app.config['MYSQL_DATABASE_DB'] = config['credentials']['database']
app.config['MYSQL_DATABASE_HOST'] = config['credentials']['host']

mysql.init_app(app)

#Called for functions that require login
@auth.verify_password
def verify(username,password):
    if not (username and password):
        return False
    conn = mysql.connect()
    cursor = conn.cursor()
    cursor.callproc('sp_AuthenticateUser',(username,))
    data = cursor.fetchall()
    return verifyPassword(password,data[0][1])

class CreateUser(Resource):
    def post(self):
        try:
            parser = reqparse.RequestParser()
            parser.add_argument('username', type=str, help='New user username')
            parser.add_argument('password', type=str, help='New user password')
            args = parser.parse_args()

            _userUsername = args['username']
            _userPassword = hash_password(args['password'])

            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('spCreateUser',(_userUsername,_userPassword,))
            data = cursor.fetchall()

            if len(data) == 0:
                conn.commit()
                return {'StatusCode':'200','Message': 'User creation success'}
            else:
                return {'StatusCode':'1000','Message': str(data[0])}

        except Exception as e:
            return {'error': str(e)}

class AuthenticateUser(Resource):
    @auth.login_required
    def get(self):
        return {'status':200}


#Returns the list of all games in the database
#Optionally allows results to be searched or sorted by date or rating
class GetAllGames(Resource):
    def post(self):
        try:
            parser = reqparse.RequestParser()
            parser.add_argument('lowerLimit', type=int, help='First game to get')
            parser.add_argument('upperLimit', type=int, help='Last game to get')
            parser.add_argument('sortType', type=str, default="Name")
            parser.add_argument('searchString', type=str, default="")
            args = parser.parse_args()

            _lowLimit = args['lowerLimit']
            _upLimit = args['upperLimit']
            _sortType = args['sortType']
            _searchString = args['searchString']

            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('sp_GetAllGames',(_lowLimit,_upLimit,))
            data = cursor.fetchall()
            dataList = [list(x) for x in data]
            #Convert dates to strings
            for tup in dataList:
                for value in tup:
                    if type(value) is datetime.date:
                        dataList[dataList.index(tup)][dataList[dataList.index(tup)].index(value)] = str(value)
                    if type(value) is decimal.Decimal:
                        dataList[dataList.index(tup)][dataList[dataList.index(tup)].index(value)] = int(value)
                if tup[7] is None:
                    tup[7] = 0

            if _searchString != "":
                dataList = [s for s in dataList if _searchString.lower() in s[0].lower()]

            if _sortType == "Date":
                dataList = sorted(dataList, key=lambda x: x[1])
            if _sortType == "Rating":
                dataList = sorted(dataList, key=lambda x: x[7],reverse=True)

            if(len(data)>0):
                return {'status':'200','Data':dataList}
        except Exception as e:
                return {'error': str(e)}

#Gets the information for a game by title
class GetGame(Resource):
    def post(self):
        try:
            parser = reqparse.RequestParser()
            parser.add_argument('name', type=str, help='Game Name')
            args = parser.parse_args()

            _name = args['name']

            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('sp_GetGame',(_name,))
            data = cursor.fetchall()
            dataList = [list(x) for x in data]
            for tup in dataList:
                for value in tup:
                    if type(value) is datetime.date:
                        dataList[dataList.index(tup)][dataList[dataList.index(tup)].index(value)] = str(value)

            if(len(data)>0):
                return {'status':'200','Data':dataList}
        except Exception as e:
            return {'error': str(e)}

class GetPublisher(Resource):
    def post(self):
        try:
            parser = reqparse.RequestParser()
            parser.add_argument('name', type=str, help='Game Name')
            args = parser.parse_args()

            _name = args['name']

            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('sp_GetPublisher',(_name,))
            data = cursor.fetchall()
            dataList = [list(x) for x in data]

            if(len(data)>0):
                return {'status':'200','Data':dataList}
        except Exception as e:
            return {'error': str(e)}

class GetDeveloper(Resource):
    def post(self):
        try:
            parser = reqparse.RequestParser()
            parser.add_argument('name', type=str, help='Game Name')
            args = parser.parse_args()

            _name = args['name']

            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('sp_GetDeveloper',(_name,))
            data = cursor.fetchall()
            dataList = [list(x) for x in data]

            if(len(data)>0):
                return {'status':'200','Data':dataList}
        except Exception as e:
            return {'error': str(e)}

class GetPlatform(Resource):
    def post(self):
        try:
            parser = reqparse.RequestParser()
            parser.add_argument('name', type=str, help='Game Name')
            args = parser.parse_args()

            _name = args['name']

            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('sp_GetPlatform',(_name,))
            data = cursor.fetchall()
            dataList = [list(x) for x in data]

            if(len(data)>0):
                return {'status':'200','Data':dataList}
        except Exception as e:
            return {'error': str(e)}

#Gets the games in the logged in user's library
class GetLibrary(Resource):
    @auth.login_required
    def post(self):
        try:
            parser = reqparse.RequestParser()
            parser.add_argument('lowerLimit', type=int, help='First game to get')
            parser.add_argument('upperLimit', type=int, help='Last game to get')
            parser.add_argument('sortType', type=str, default="Name")
            parser.add_argument('searchString', type=str, default="")
            parser.add_argument('username', type=str, help='Username to get library')
            args = parser.parse_args()

            _lowLimit = args['lowerLimit']
            _upLimit = args['upperLimit']
            _userUsername = args['username']
            _sortType = args['sortType']
            _searchString = args['searchString']

            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('sp_GetLibrary',(_lowLimit,_upLimit,_userUsername,))
            data = cursor.fetchall()
            dataList = [list(x) for x in data]
            for tup in dataList:
                for value in tup:
                    if type(value) is datetime.date:
                        dataList[dataList.index(tup)][dataList[dataList.index(tup)].index(value)] = str(value)
                if tup[9] is None:
                    tup[9] = 0

            if _searchString != "":
                dataList = [s for s in dataList if _searchString.lower() in s[0].lower()]

            if _sortType == "Date":
                dataList = sorted(dataList, key=lambda x: x[1])
            if _sortType == "Rating":
                dataList = sorted(dataList, key=lambda x: x[9],reverse=True)

            if(len(data)>0):
                return {'status':'200','Data':dataList}
        except Exception as e:
            return {'error': str(e)}

class RemoveFromLibrary(Resource):
    @auth.login_required
    def post(self):
        try:
            parser = reqparse.RequestParser()
            parser.add_argument('username', type=str, help='Username to remove from')
            parser.add_argument('game', type=str, help='Game to remove')
            parser.add_argument('platform', type=str, help='Platform of game')
            args = parser.parse_args()

            _username = args['username']
            _game = args['game']
            _platform = args['platform']

            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('sp_RemoveFromLibrary',(_username,_game,_platform,))
            conn.commit()

            return {'status':'200'}
        except Exception as e:
            return {'error': str(e)}

class AddToLibrary(Resource):
    @auth.login_required
    def post(self):
        try:
            parser = reqparse.RequestParser()
            parser.add_argument('username', type=str, help='Username to remove from')
            parser.add_argument('game', type=str, help='Game to remove')
            parser.add_argument('platform', type=str, help='Platform of game')
            args = parser.parse_args()

            _username = args['username']
            _game = args['game']
            _platform = args['platform']

            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('sp_AddToLibrary',(_username,_game,_platform,))
            conn.commit()

            return {'status':'200'}
        except Exception as e:
            return {'error': str(e)}

class AddToWishlist(Resource):
    @auth.login_required
    def post(self):
        try:
            parser = reqparse.RequestParser()
            parser.add_argument('username', type=str, help='Username to remove from')
            parser.add_argument('game', type=str, help='Game to remove')
            args = parser.parse_args()

            _username = args['username']
            _game = args['game']

            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('sp_AddToWishlist',(_username,_game,))
            conn.commit()

            return {'status':'200'}
        except Exception as e:
            return {'error': str(e)}

class RemoveFromWishlist(Resource):
    @auth.login_required
    def post(self):
        try:
            parser = reqparse.RequestParser()
            parser.add_argument('username', type=str, help='Username to remove from')
            parser.add_argument('game', type=str, help='Game to remove')
            args = parser.parse_args()

            _username = args['username']
            _game = args['game']

            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('sp_RemoveFromWishlist',(_username,_game,))
            conn.commit()

            return {'status':'200'}
        except Exception as e:
            return {'error': str(e)}

class AddToFavorites(Resource):
    @auth.login_required
    def post(self):
        try:
            parser = reqparse.RequestParser()
            parser.add_argument('username', type=str, help='Username to remove from')
            parser.add_argument('game', type=str, help='Game to remove')
            parser.add_argument('platform', type=str, help='Platform of game')
            args = parser.parse_args()

            _username = args['username']
            _game = args['game']
            _platform = args['platform']

            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('sp_AddToFavorites',(_username,_game,_platform,))
            conn.commit()

            return {'status':'200'}
        except Exception as e:
            return {'error': str(e)}

class GetWishlist(Resource):
    @auth.login_required
    def post(self):
        try:
            parser = reqparse.RequestParser()
            parser.add_argument('lowerLimit', type=int, help='First game to get')
            parser.add_argument('upperLimit', type=int, help='Last game to get')
            parser.add_argument('sortType', type=str, default="Name")
            parser.add_argument('searchString', type=str, default="")
            parser.add_argument('username', type=str, help='Username to get library')
            args = parser.parse_args()

            _lowLimit = args['lowerLimit']
            _upLimit = args['upperLimit']
            _userUsername = args['username']
            _sortType = args['sortType']
            _searchString = args['searchString']

            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('sp_GetWishlist',(_lowLimit,_upLimit,_userUsername,))
            data = cursor.fetchall()
            dataList = [list(x) for x in data]
            for tup in dataList:
                for value in tup:
                    if type(value) is datetime.date:
                        dataList[dataList.index(tup)][dataList[dataList.index(tup)].index(value)] = str(value)
                    if type(value) is decimal.Decimal:
                        dataList[dataList.index(tup)][dataList[dataList.index(tup)].index(value)] = float(value)
                if tup[7] is None:
                    tup[7] = 0

            if _searchString != "":
                dataList = [s for s in dataList if _searchString.lower() in s[0].lower()]

            if _sortType == "Date":
                dataList = sorted(dataList, key=lambda x: x[1])
            if _sortType == "Rating":
                dataList = sorted(dataList, key=lambda x: x[7],reverse=True)

            if(len(data)>0):
                return {'status':'200','Data':dataList}
        except Exception as e:
            return {'error': str(e)}

class GetFavorites(Resource):
    @auth.login_required
    def post(self):
        try:
            parser = reqparse.RequestParser()
            parser.add_argument('lowerLimit', type=int, help='First game to get')
            parser.add_argument('upperLimit', type=int, help='Last game to get')
            parser.add_argument('sortType', type=str, default="Name")
            parser.add_argument('searchString', type=str, default="")
            parser.add_argument('username', type=str, help='Username to get library')
            args = parser.parse_args()

            _lowLimit = args['lowerLimit']
            _upLimit = args['upperLimit']
            _userUsername = args['username']
            _sortType = args['sortType']
            _searchString = args['searchString']

            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('sp_GetFavorites',(_lowLimit,_upLimit,_userUsername,))
            data = cursor.fetchall()
            dataList = [list(x) for x in data]
            for tup in dataList:
                for value in tup:
                    if type(value) is datetime.date:
                        dataList[dataList.index(tup)][dataList[dataList.index(tup)].index(value)] = str(value)
                if tup[9] is None:
                    tup[9] = 0


            if _searchString != "":
                dataList = [s for s in dataList if _searchString.lower() in s[0].lower()]

            if _sortType == "Date":
                dataList = sorted(dataList, key=lambda x: x[1])
            if _sortType == "Rating":
                dataList = sorted(dataList, key=lambda x: x[9],reverse=True)

            if(len(data)>0):
                return {'status':'200','Data':dataList}
        except Exception as e:
            return {'error': str(e)}

class RemoveFromFavorites(Resource):
    @auth.login_required
    def post(self):
        try:
            parser = reqparse.RequestParser()
            parser.add_argument('username', type=str, help='Username to remove from')
            parser.add_argument('game', type=str, help='Game to remove')
            parser.add_argument('platform', type=str, help='Platform of game')
            args = parser.parse_args()

            _username = args['username']
            _game = args['game']
            _platform = args['platform']

            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('sp_RemoveFromFavorites',(_username,_game,_platform,))
            conn.commit()

            return {'status':'200'}
        except Exception as e:
            return {'error': str(e)}

class RateGame(Resource):
    @auth.login_required
    def post(self):
        try:
            parser = reqparse.RequestParser()
            parser.add_argument('rating', type=str, help='Game rating')
            parser.add_argument('username', type=str, help='Username to rate game for')
            parser.add_argument('platform', type=str, help='Game platform')
            parser.add_argument('game', type=str, help='Game to rate')
            args = parser.parse_args()

            _rating = int(args['rating'])
            _username = args['username']
            _platform = args['platform']
            _game = args['game']

            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('sp_RateGame',(_rating,_username,_game,_platform,))
            conn.commit()

            return {'status':'200'}
        except Exception as e:
            return {'error': str(e)}

class AddGame(Resource):
    @auth.login_required
    def post(self):
        try:
            parser = reqparse.RequestParser()
            parser.add_argument('platform', type=str, help='Game platform')
            parser.add_argument('game', type=str, help='Game name')
            parser.add_argument('release_date', type=str, help='Game Release Date')
            parser.add_argument('series', type=str, help='Game series')
            parser.add_argument('genre', type=str, help='Game genre')
            parser.add_argument('cover_art', type=str, help='Game cover art')
            parser.add_argument('developer', type=str, help="Game developers")
            parser.add_argument('publisher', type=str, help='Game publishers')
            args = parser.parse_args()

            _genre = args['genre']
            _platform = args['platform'].split(',')
            _game = args['game']
            _release_date = args['release_date']
            _series = args['series']
            _cover_art = args['cover_art']
            _developer = args['developer'].split(',')
            _publisher = args['publisher'].split(',')

            conn = mysql.connect()
            cursor = conn.cursor()

            for plat in _platform:
                cursor.callproc('sp_AddPlatform',(plat,))
                conn.commit()

            for pub in _publisher:
                cursor.callproc('sp_AddCompany',(pub,))
                conn.commit()

            for dev in _developer:
                cursor.callproc('sp_AddCompany',(dev,))
                conn.commit()

            cursor.callproc('sp_AddGenre',(_genre,))
            conn.commit()

            cursor.callproc('sp_AddGame',(_game,_release_date,_series,_cover_art,_genre))
            conn.commit()

            for plat in _platform:
                cursor.callproc('sp_AddGamePlatform',(_game,plat,))
                conn.commit()

            for pub in _publisher:
                cursor.callproc('sp_AddGamePublisher',(_game,pub,))
                conn.commit()

            for dev in _developer:
                cursor.callproc('sp_AddGameDeveloper',(_game,dev,))
                conn.commit()

            return {'status':'200'}
        except Exception as e:
            return {'error': str(e)}

class RemoveGame(Resource):
    @auth.login_required
    def post(self):
        try:
            parser = reqparse.RequestParser()
            parser.add_argument('game', type=str, help='Game to remove')
            args = parser.parse_args()

            _game = args['game']

            conn = mysql.connect()
            cursor = conn.cursor()
            cursor.callproc('sp_RemoveGame',(_game,))
            conn.commit()

            return {'status':'200'}
        except Exception as e:
            return {'error': str(e)}


api.add_resource(CreateUser, '/CreateUser')
api.add_resource(AuthenticateUser, '/AuthenticateUser')
api.add_resource(GetAllGames, '/GetAllGames')
api.add_resource(GetGame, '/GetGame')
api.add_resource(GetPublisher, '/GetPublisher')
api.add_resource(GetDeveloper, '/GetDeveloper')
api.add_resource(GetPlatform, '/GetPlatform')
api.add_resource(GetLibrary, '/GetLibrary')
api.add_resource(GetWishlist, '/GetWishlist')
api.add_resource(GetFavorites, '/GetFavorites')
api.add_resource(RemoveFromLibrary, '/RemoveFromLibrary')
api.add_resource(AddToLibrary, '/AddToLibrary')
api.add_resource(AddToWishlist, '/AddToWishlist')
api.add_resource(AddToFavorites, '/AddToFavorites')
api.add_resource(RemoveFromWishlist, '/RemoveFromWishlist')
api.add_resource(RemoveFromFavorites, '/RemoveFromFavorites')
api.add_resource(RateGame, '/RateGame')
api.add_resource(AddGame, '/AddGame')
api.add_resource(RemoveGame, '/RemoveGame')

if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0')



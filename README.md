# DaemonFirebase
a Daemon In Python For Firebase Realtime Data Base Update

Un Script Simple en python para automatizar tareas de actualizacion de datos en firebase realtime database

incluye el archivo .sh para integrarlo como un servicio en linux tambien tiene funciones para registrar en un log cada vez que sube la informacion 


# -*- coding: utf-8 -*-
import firebase_admin
from firebase_admin import credentials
from firebase_admin import db
import time
import datetime
import pymysql
from daemon import runner
import logging
#mysql credentials / credenciales mysql
DB_HOST = 'localhost' 
DB_USER = 'user' 
DB_PASS = '123456' 
DB_NAME = 'dbname'
# Codigo del Daemon 
class App():
   def __init__(self):
      self.stdin_path      = '/dev/null'
      self.stdout_path     = '/dev/tty'
      self.stderr_path     = '/dev/tty'
      self.pidfile_path    =  '/var/run/daemonfirebase.pid'
      self.pidfile_timeout = 5

   def run(self):
       #
       i = 0
       # las credenciales de firebase / firebase credencials
       cred = credentials.Certificate('/path/to/googlejson/Conf-FireBase.json')
       # inicializo la conexion con firebase y mi base de datos / initialize the firebase conection
       firebase_admin.initialize_app(cred, {
            'databaseURL': 'https://yoururlfirebasedatabaserealtime.firebaseio.com'
       })
       while True:
            i += 1
            #
            #inicio de sentencias  codigo personalizado del daemon / init the daemon sentences
            # Abre conexion con la base de datos / open the mysql conection
            dbmysql = pymysql.connect(DB_HOST,DB_USER,DB_PASS,DB_NAME)

            # prepare a cursor object using cursor() method / prepare the cursor
            cursor = dbmysql.cursor()
            # Preparo el Sql / prepare sql
            query = "select 1"  
            # ejecuta el SQL query usando el metodo execute(). / execute the sql sentence
            cursor.execute(query)
            # procesa una unica linea usando el metodo fetchone(). / unic row fetch
			data_historico=cursor.fetchone() 
            # desconecta del servidor / close conection
            dbmysql.close()

            #obtengo el sitio donde quiero escribir mis datos / obtain database from firebase NOSQL database
            ref = db.reference('/db/'+str(data[0]))
            #creo una nueva hora
            hora_reg = ref.child(str(data[3])).set({
                'data': {
                    'example1': data[0]
                }
            })
            #tiempo de ejecucion en segundos / time for loop in seconds
            time.sleep(60)
            #registro la actividad / Activity register 
            logger.info("Registro Ejecutado con Exito "+str(i))
#parte final del codigo personalizado empieza final del daemon / personal code ending begin the end of daemon
if __name__ == '__main__':
   app = App()
   logger = logging.getLogger("testlog")
   logger.setLevel(logging.INFO)
   formatter = logging.Formatter("%(asctime)s - %(name)s - %(message)s")
   handler = logging.FileHandler("/your/path/registro.log")
   handler.setFormatter(formatter)
   logger.addHandler(handler)

   serv = runner.DaemonRunner(app)
   serv.daemon_context.files_preserve=[handler.stream]
   serv.do_action()

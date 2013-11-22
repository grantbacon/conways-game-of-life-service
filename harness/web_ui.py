from bottle import run, route, request, template, static_file
import subprocess
import json
import os


ADDR='localhost'
PORT='8080'
STATIC_DIR='static'
GAME_OF_LIFE_EXEC='game_of_life.sh'


@route('/static/<filepath:path>')
def static(filepath):
	return static_file(filepath, root=STATIC_DIR)

@route('/about')
def about():
    return template('about')

@route('/')
def index():
    return template('index')

@route('/nextgen')
def nextgen():
    executable = os.path.join(os.path.dirname(os.path.abspath(__file__)), GAME_OF_LIFE_EXEC)
    print executable
    acl2 = subprocess.Popen(executable, stdout=subprocess.PIPE)
    return acl2.stdout.read()


run(host=ADDR, port=PORT)

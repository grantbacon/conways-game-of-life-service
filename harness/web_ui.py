from bottle import run, route, request, template, static_file
import subprocess
import json
import os


ADDR='localhost'
PORT='8085'
STATIC_DIR='static'
GAME_OF_LIFE_EXEC='Conway'


def relative_path(suffix):
    return os.path.join(os.path.dirname(os.path.abspath(__file__)), suffix)

@route('/static/<filepath:path>')
def static(filepath):
	return static_file(filepath, root=relative_path(STATIC_DIR))

@route('/about')
def about():
    return template('about')

@route('/')
def index():
    return template('index')

@route('/nextgen', method='POST')
def nextgen_post():
    executable = relative_path(GAME_OF_LIFE_EXEC)
    generation_data = request.body.read()

    acl2 = subprocess.Popen(executable, stdout=subprocess.PIPE, stdin=subprocess.PIPE)
    result = acl2.communicate(input = generation_data)[0]

    return result

run(host=ADDR, port=PORT)

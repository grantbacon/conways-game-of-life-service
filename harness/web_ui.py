from bottle import run, route, request, template, static_file
import subprocess
import json


ADDR='localhost'
PORT='8080'
STATIC_DIR='static'


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
    acl2 = subprocess.Popen('/Users/grant/repo/harness/game_of_life.sh', stdout=subprocess.PIPE)
    return acl2.stdout.read()


run(host=ADDR, port=PORT)

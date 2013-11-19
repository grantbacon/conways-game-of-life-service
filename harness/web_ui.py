from bottle import run, route, request, template, static_file
from config import Config
import subprocess
import json

cfg = Config('gameoflife.cfg')

@route('/static/<filepath:path>')
def static(filepath):
	return static_file(filepath, root=cfg.static_dir)

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


run(host=cfg.addr, port=cfg.port)

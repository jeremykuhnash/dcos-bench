"""
Example python app with the Flask framework: http://flask.pocoo.org/
"""

from os import environ
import sys
from flask import Flask
from flask import render_template
from flask import request
from flask import jsonify

app = Flask(__name__)

@app.route('/', defaults={'path': ''})
@app.route('/<path:path>')
def index(path):
    host = '<host unset>'
    remote = '<remote unset>'
    environment = ['<environ not set>']
    e = sys.exc_info()[0]
    try:
        # do not understand how but sometimes flask request doesnt have this key
        host = request.headers['Host']
        remote = request.remote_addr
        environment = environ
    except:
         e = sys.exc_info()[0]
         print( "<p>Error: %s</p>" % e )
    print ("Requested: '" + host + "/" + path + "' -- From IP: " + remote)
    return render_template('index.html', path=path, host=host, environment=environment, remote=remote)


if __name__ == '__main__':
    # Bind to PORT if defined, otherwise default to 5000.
    port = int(environ.get('PORT', 5000))
    app.run(host='0.0.0.0', port=port)

from flask import Flask, request
from twilio.rest import Client
import urllib.request
from bottle import route, run, template, static_file, get, post, request


app = Flask(__name__)
 
# put your own credentials here
ACCOUNT_SID = 'SID'
AUTH_TOKEN = 'TOKEN'

client = Client(ACCOUNT_SID, AUTH_TOKEN)

@app.route("/")
def hello():
    return "hey its me"

@app.route('/sms', methods=['POST'])
def send_sms():
    message = client.messages.create(
        to=request.form['To'], 
        from_= request.form['From'],
        body=request.form['Body'],
    )
 
    return message.sid

@app.route('/test')
def test():
	print("hey")
	userid = request.GET.get('userid')
	print(userid)
	image = urllib.request.urlopen('https://emergencyapp-15097.firebaseio.com/' + '8RCeBan4iPZmirWaH2RRaU2XjhM2' + '/name.json').read()
	print('OUTPUT' + image)
	return image

if __name__ == '__main__':
        app.run()


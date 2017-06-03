from flask import Flask, request
from twilio.rest import Client
import urllib.request
# from bottle import route, run, template, static_file, get, post, request
import requests
from secret import getSID, getAuth, getAuthy
import string
import re
import json

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
    # http://30e415d8.ngrok.io/test?userid=8RCeBan4iPZmirWaH2RRaU2XjhM2
	print("hey")
	userid = request.args.get("userid")
	image = urllib.request.urlopen('https://emergencyapp-15097.firebaseio.com/' + userid + '/name.json').read()
	return image

@app.route('/sendverificationcode')
def sendverificationcode():
    # http://30e415d8.ngrok.io/sendverificationcode?countrycode=1&number=6505754922
    sid = getSID()
    authtoken = getAuth()
    authytoken = getAuthy()
    number = request.args.get("number")
    countrycode = request.args.get("countrycode")

    # sending
    url = 'https://api.authy.com/protected/json/phones/verification/start?api_key=' + authytoken + '&via=sms&country_code=' + countrycode + '&phone_number=' + number + '&code_length=6&locale=en'
    data = {
        'url': url
    }

    headers = {
        'Content-Type': 'json',
    }

    r = requests.post(url, data=json.dumps(data), headers=headers)
    json1_data = json.loads(r.text)

    print(r.text)
    print(json1_data)

    # 'https://api.authy.com/protected/{json,xml}/phones/verification/start?api_key=' + authytoken + '&via=sms&country_code=' + countrycode + '&phone_number=' + number + '&code_length=6&locale=en'
    
    return r.text

@app.route('/verify')
def verify():
    # http://30e415d8.ngrok.io/verify?code=536747&phone_number=6505754922&country_code=1
    verification_code = request.args.get("code")
    country_code = request.args.get("country_code")
    phone_number = request.args.get("phone_number")
    authytoken = getAuthy()
    result = urllib.request.urlopen('https://api.authy.com/protected/json/phones/verification/check?api_key=' + authytoken + '&country_code=' + country_code + '&phone_number=' + phone_number + '&verification_code=' + verification_code).read()
    
    return result

if __name__ == '__main__':
        app.run()


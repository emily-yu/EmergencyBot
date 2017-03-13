from flask import Flask, request
from twilio.rest import TwilioRestClient
app = Flask(__name__)
 
# put your own credentials here
ACCOUNT_SID = 'ACce55d5efd911222f6eba43f84ee79acd' #ACCOUNT_SID = 'SID'
AUTH_TOKEN = '300a352d939cb8a6ae3a0163b3d9f55d' #AUTH_TOKEN = 'TOKEN'
 
client = TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN)

@app.route("/")
def hello():
    return "Hello World!"

@app.route('/sms', methods=['POST'])
def send_sms():
    message = client.messages.create(
        to=request.form['To'], 
        from_= request.form['From'],
        body=request.form['Body'],
    )
 
    return message.sid
 
if __name__ == '__main__':
        app.run()


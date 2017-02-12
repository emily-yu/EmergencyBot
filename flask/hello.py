from flask import Flask, request
 
from twilio.rest import TwilioRestClient
 
app = Flask(__name__)
 
# put your own credentials here 
ACCOUNT_SID = 'YOUR_ACCOUNT_SID' 
AUTH_TOKEN = 'YOUR_AUTH_TOKEN' 
 
client = TwilioRestClient(ACCOUNT_SID, AUTH_TOKEN)
 
@app.route('/sms', methods=['POST'])
def send_sms():
    message = client.messages.create(
        to=request.form['To'], 
        from_='YOUR_TWILIO_PHONE_NUMBER', 
        body=request.form['Body'],
    )
 
    return message.sid
 
if __name__ == '__main__':
        app.run()
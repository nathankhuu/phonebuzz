# Phonebuzz

Hosted At: myphonebuzz.herokuapp.com  
Application Phone Number: (619) 305-0734  

## Getting Started

This application was built with Ruby 2.4.0 and Rails 5.0.6. 

### Running Locally

First, setup environment varibles for `TWILIO_NUMBER`, `TWILIO_AUTH_TOKEN`, and `TWILIO_SID`.  
`TWILIO_NUMBER`: The Twilio phone number to use  
`TWILIO_AUTH_TOKEN` and `TWILIO_SID`: Listed with Twilio account info   

After downloading the repo, remember to

```
bundle install
```

and

```
rake db:migrate
```

Run a rails server

```
rails s
```

In a new window or tab, run this to handle the delayed jobs automatically

```
bin/delayed_job start
```

We also need the local app to reach the Internet to make the calls. One way to to do this is with [ngrok](https://ngrok.com/).

```
~/ngrok http 3000
```

Follow the link provided by ngrok, under "Forwarding", and this should lead to a live url of the app. 


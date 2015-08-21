#!/usr/local/bin/python #TODO location of the python 

from SimpleCV import *
import smtplib
from email.MIMEMultipart import MIMEMultipart
from email.MIMEText import MIMEText

def imageCompare(img1, img2):
	diff = img2 - img1
	### troubleshooting
	#diff.show()
	area = diff.width * diff.height
	matrix = diff.getNumpy()
	flat = matrix.flatten()
	counter = 0
	for i in flat:
        if flat[i] == 0: #if black
                counter += 1

	percentChange = float(counter) / float(len(flat))

	return percentChange

def emailOut(change):
	sender = #TODO
	recipients = ['portiad@gmail.com', 'jeff.nickoloff@gmail.com']

	msg = MIMEMultipart()
	msg['From'] = sender
	msg['To'] = ", ".join(recipients)
	if change == 1:
		msg['Subject'] = "Someone is Home!"
	else:
			msg['Subject'] = "Someone left!"

	try:
	   smtpObj = smtplib.SMTP('localhost') #TODO
	   smtpObj.sendmail(sender, recipients, msg.as_string())         
	   print "Successfully sent email"
	except SMTPException:
	   print "Error: unable to send email"

cam = Camera()
carCount = 0
totalCars = 2
percentThreshold = .9

while True:
	prev = cam.getImage()
	time.sleep(2.0)
	current = cam.getImage()
	change = imageCompare(prev, current)
	
	if change >= percentThreshold:
		time.sleep(10.0)
		new = cam.getImage()
		review = imageCompare(current, new)

		if review >= percentThreshold: # new shot has 90% changes from current shot
			if carCount == 0: # 1st car is arriving
				carCount = 1
				emailOut(1)
			else:
				carCount = 0 # 1st car is leaving
				emailOut(-1)
		else:
			if carCount == 2: # 2nd car is leaving
				carCount = 1
				emailOut(-1)
			else:
				carCount = 2 # 2nd car is arriving
				emailOut(1)

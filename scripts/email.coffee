# Description:
#   Allows you to send emails via hubot.
#
# Dependencies:
#   "nodemailer": "0.5.2"
#
# Configuration:
#   HUBOT_EMAIL_USER - The Gmail address from which to send emails.
#   HUBOT_EMAIL_PWD  - The password associated with the account.
#
# Commands:
#   hubot email <address@example.com> -s "<subject>" -m "<message>"
#   hubot email:kill   - Destroys ability to send email.
#   hubot email:reinit - Reinitializes the ability to send email after a kill.
#
# Author:
#   jgnewman

nodemailer    = require "nodemailer"
smtpTransport = null

# Create reusable transport method (opens pool of SMTP connections)
createTransport = ->
  smtpTransport = nodemailer.createTransport "SMTP", {
      service: "Mandrill",
      auth: {
          user: "anchitjain1234@yandex.com",
          pass: 'eQleUFaeFGkbcV9gxY87oQ'
      }
  }

# Create an initial transport object
createTransport()

module.exports = (robot) ->

  # Destroy the mail pool.
  robot.respond /email\:kill/i, (msg) ->
    if not smtpTransport
      msg.send 'There is currently no mail pool to kill.'
    else
      smtpTransport.close();
      smtpTransport = null;
      msg.send 'Ok. I just killed the whole mail pool.'

  # Initialize the mail pool.
  robot.respond /email\:reinit/i, (msg) ->
    if smtpTransport
      msg.send 'Email is already initialized.'
    else
      createTransport()
      msg.send 'Ok. I just initialized a mailing pool.'

  # Respond to an email command
  robot.respond ///
    email\s+ # The word email
    ([^\@]+\@[^\s]+) # An email address
    ( # Any amount of the following
      \s*\-s\s+(\')[^\']*(\') | # Single quoted subject line
      \s*\-s\s+(\")[^\"]*(\") | # Double quoted subject line
      \s*\-m\s+(\')[^\']*(\') | # Single quoted message line
      \s*\-m\s+(\")[^\"]*(\")   # Double quoted message line
    )+
  ///i, (msg) ->
    mailto  = msg.match[1]
    subject = msg.match[0].match(/\s*\-s\s+(\')[^\']*(\')|\s*\-s\s+(\")[^\"]*(\")/i)
    message = msg.match[0].match(/\s*\-m\s+(\')[^\']*(\')|\s*\-m\s+(\")[^\"]*(\")/i)
    if subject
      subject = subject[0].replace(/^\s*\-s\s*/g, '').trim().replace(/^(\'|\")|(\'|\")$/g, '')
    if message
      message = message[0].replace(/^\s*\-m\s*/g, '').trim().replace(/^(\'|\")|(\'|\")$/g, '')

    # Create an object to inform our mailing procedure
    obj = {
      from: "MYBOT <anchitjain1234@gmail.com>",
      to: mailto,
      subject: subject or "From MyBOT @ https://bitspilani8.campfirenow.com/ff6d5 "
      text: message or ""
    }

    if not message
      msg.send "I refuse to send an email with no message body."
    else
      if not smtpTransport
        msg.send "Mail is not currently initialized."
      else
        # send mail with defined transport object
        smtpTransport.sendMail obj, (error, response) ->
          if error
            msg.send "There was an error: " + error
          else
            msg.send "Ok. I sent the email."

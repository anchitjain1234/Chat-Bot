# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md
anticursingresponse = [
      "Profanity is the weapon of the witless",
      "Profanity is the common crutch of the conversational cripple",
      "When a man uses profanity to support an argument, it indicates that either the man or the argument is weak - probably both",
      "Profanity is the attempt of a lazy and feeble mind to express itself forcefully",
      "A vessel is known by the sound, whether it be cracked or not, so men are proved by their speeches whether they be wise or not.",
      "Such as thy words are, such will thine affections be esteemed; and such as thine affections, will be thy deeds; and such as thy deeds will be thy life.",
      "A superior man is modest in his speech, but exceeds in his actions.",
      "Swearing is usually a good indicator of an inadequate vocabulary with which one is unable to adequately express their true feelings in an appropriate manner.",
      "A person's speech is a mirror that reflects the true interior character of the individual."
    ]

module.exports = (robot) ->

    

   robot.hear /fuck/i, (res) ->
     res.send res.random anticursingresponse

   robot.respond /hello/i, (res) ->
     res.reply "Hello there."

   robot.hear /hello/i, (res) ->
     res.reply "Are you welcoming me? . I am just a BOT. You are awesome."

   robot.hear /yo/i, (res) ->
     res.reply "Yo."

   robot.respond /who is your owner/i, (res) ->
     res.send "Anchit Jain is my owner."

   robot.respond /who created you/i, (res) ->
     res.send "Anchit Jain created me."

   robot.respond /who is your master/i, (res) ->
     res.send "Anchit Jain is my master."
  #
  #
   robot.topic (res) ->
     res.send "#{res.message.text}? That's a Paddlin'"
  #
  #
   enterReplies = ['Hi', 'Target Acquired', 'Firing', 'Hello friend.', 'Gotcha', 'I see you']
   leaveReplies = ['Are you still there?', 'Target lost', 'Searching']
  #
   robot.enter (res) ->
     res.send res.random enterReplies
   robot.leave (res) ->
     res.send res.random leaveReplies
  #
  #
  #
   robot.respond /you are a little slow/, (res) ->
     setTimeout () ->
       res.send "Who you calling 'slow'?"
     , 60 * 1000
  #
  #
  #
   robot.router.post '/hubot/chatsecrets/:room', (req, res) ->
     room = req.params.room
     data = JSON.parse req.body.payload
     secret = data.secret
  #
     robot.messageRoom room, "I have a secret: #{secret}"
  #
     res.send 'OK'
  #
   robot.error (err, res) ->
     robot.logger.error "DOES NOT COMPUTE"
  #
     if res?
       res.reply "DOES NOT COMPUTE"
  #

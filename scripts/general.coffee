# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

module.exports = (robot) ->

   robot.hear /fuck/i, (res) ->
     res.send "Please dont abuse you MOTHERFUCKING FUCK. Only I have the right to abuse."

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

   robot.catchAll (msg) ->
     msg.send "I don't know how to react to: #{msg.message.text} . Please try 'mybot help' to see list of available commands or 'mybot pb <query>' for more generic answer. Thank You."

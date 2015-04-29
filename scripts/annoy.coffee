# Description:
#   Get annoyed from mybot.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot annoy me - The bot starts annoying you.
#   hubot unannoy me - The bot stops annoying you.
#
# Author:
#   Anchit Jain.

module.exports = (robot) ->

  annoyIntervalId = null
 #
  robot.respond /annoy me/, (res) ->
    if annoyIntervalId
      res.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
      return
 #
    res.send "Hey, want to hear the most annoying sound in the world?"
    annoyIntervalId = setInterval () ->
      res.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
    , 1000


    robot.respond /unannoy me/, (res) ->
      if annoyIntervalId
        res.send "GUYS, GUYS, GUYS!"
        clearInterval(annoyIntervalId)
        annoyIntervalId = null
      else
        res.send "Not annoying you right now, am I?"

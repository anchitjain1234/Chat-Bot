# Description:
#   Bot stops being annoying.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot unannoy me - The bot stops annoying you.
#
# Author:
#   Anchit Jain.

module.exports = (robot) ->

  robot.respond /unannoy me/, (res) ->
    if annoyIntervalId
      res.send "GUYS, GUYS, GUYS!"
      clearInterval(annoyIntervalId)
      annoyIntervalId = null
    else
      res.send "Not annoying you right now, am I?"

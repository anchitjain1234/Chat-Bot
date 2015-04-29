# Description:
#   Bot driks a soda.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot have a soda - The bot drinks a soda.
#   hubot sleep it off - Bot sleeps off and forgets all about previous HANGOVER.
#
# Author:
#   Anchit Jain.

module.exports = (robot) ->

  robot.respond /have a soda/i, (res) ->
    # Get number of sodas had (coerced to a number).
    sodasHad = robot.brain.get('totalSodas') * 1 or 0
 #
    if sodasHad > 4
      res.reply "I'm too fizzy.."
 #
    else
      res.reply 'Sure!'
 #
      robot.brain.set 'totalSodas', sodasHad + 1
 #
  robot.respond /sleep it off/i, (res) ->
    robot.brain.set 'totalSodas', 0
    res.reply 'zzzzz'

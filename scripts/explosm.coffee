# Description:
# Returns a random comic strip from Cyanide and Happiness website.
#
# Dependencies:
# "cheerio": "0.7.0"
# 
# 
#
# Configuration:
# None
#
# Commands:
# hubot c&h - Returns random comic strip from Cyanide and Happiness.
#
# Author:
# Anchit Jain


cheerio     = require('cheerio')
util        = require "util"


module.exports = (robot)->
  robot.respond /c&h( me)?/i, (message)->
    send_meme message, 'http://explosm.net/comics/random', (text)->
      message.send text

send_meme = (message, location, response_handler)->
  url = location

  message.http(url).get() (error, response, body)->
    return response_handler "Sorry, something went wrong" if error

    if response.statusCode == 302 || response.statusCode == 301
      location = response.headers['location']
      location='http://explosm.net' + location
      return send_meme(message, location, response_handler)
    img_src = get_meme_image(body, "#comic-container img")

    response_handler "http:#{img_src}"

get_meme_image = (body, selector)->
  $ = cheerio.load(body)
  $(selector).first().attr('src')

# Description:
# Returns the info of entered movie from imdb.
#
# Dependencies:
# "util":"*"
#
# Configuration:
# None
#
# Commands:
# hubot imdb moviename - Returns information of entered movie from indb.
#
# Author:
# Anchit Jain
util = require "util"
module.exports = (robot) ->
  robot.respond /imdb (.*)/i, (msg) ->
    moviename = escape(msg.match[1])
    apiurl = "http://www.myapifilms.com/imdb?title=#{moviename}&format=JSON&aka=0&business=0&seasons=0&seasonYear=0&technical=0&filter=N&exactFilter=0&limit=1&forceYear=0&lang=en-us&actors=S&biography=0&trailer=0&uniqueName=0&filmography=0&bornDied=0&starSign=0&actorActress=0&actorTrivia=0&movieTrivia=0&awards=0&moviePhotos=N&movieVideos=N&token=c618d1ac-0398-4605-8061-49b1b49b95a4&similarMovies=0"
    msg.http(apiurl).get() (err, res, body) ->
      try
        json = JSON.parse(body)
        msg.send "\n    Title: #{json[0].title},  IMDB URL: #{json[0].urlIMDB}\n    Directors: "
        len = json[0].directors.length
        i = 0
        while (i < len)
          msg.send "       #{json[0].directors[i].name}"
          i += 1
        msg.send "    Actors:"
        len = json[0].actors.length
        i = 0
        while (i < len)
          msg.send "       #{json[0].actors[i].actorName}"
          i += 1
        msg.send "    Plot: #{json[0].plot}\n    Releasedate: #{json[0].releaseDate}\n    Rating: #{json[0].rating}"
        mscore=json[0].metascore
        if mscore
          msg.send "    Metascore:#{mscore}\n"
      catch error
        msg.send "Movie not found."

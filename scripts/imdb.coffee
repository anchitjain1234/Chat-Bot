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
    apikey=process.env.MYAPIFILMS_TOKEN
    apiurl = "http://www.myapifilms.com/imdb?title=#{moviename}&format=JSON&aka=0&business=0&seasons=0&seasonYear=0&technical=0&filter=N&exactFilter=0&limit=1&forceYear=0&lang=en-us&actors=S&biography=0&trailer=0&uniqueName=0&filmography=0&bornDied=0&starSign=0&actorActress=0&actorTrivia=0&movieTrivia=0&awards=0&moviePhotos=N&movieVideos=N&token=#{apikey}&similarMovies=0"
    msg.http(apiurl).get() (err, res, body) ->
      try
        json = JSON.parse(body)
        response= "\n     Title: #{json[0].title},  IMDB URL: #{json[0].urlIMDB}\n    IMDBRating: #{json[0].rating}\n    ReleaseYear: #{json[0].year}  ,  Length: #{json[0].runtime[0]}  ,  Rating: #{json[0].rated}\n"
        mscore=json[0].metascore
        if mscore
          response += "    Metascore:#{mscore}\n"
        response+="    Director(s): \n"
        len = json[0].directors.length
        i = 0
        while (i < len)
          response += "       #{json[0].directors[i].name} \n"
          i += 1
        response += "    Actors:\n"
        len = 2
        i = 0
        while (i < len)
          response += "       #{json[0].actors[i].actorName}\n"
          i += 1
        response += "     Plot: #{json[0].plot}\n"
        response += "     Poster Image: #{json[0].urlPoster}\n"

        msg.send "#{response}"
      catch error
        msg.send "Movie not found."

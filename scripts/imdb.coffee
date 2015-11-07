#
# Description:
#   Get the movie poster and synposis for a given query
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot imdb the matrix
#
# Author:
#   orderedlist

module.exports = (robot) ->
  robot.respond /(imdb|movie)( me)? (.*)/i, (msg) ->
    query = msg.match[3]
    msg.http("http://omdbapi.com/")
      .query({
        t: query,
        tomatoes: true
      })
      .get() (err, res, body) ->
        movie = JSON.parse(body)
        if movie
          text = "#{movie.Title} (#{movie.Year})\n"
          text += "http://www.imdb.com/title/#{movie.imdbID}\n"
          text += "RT: #{movie.tomatoMeter}% Fresh/Rotten: #{movie.tomatoFresh}/#{movie.tomatoRotten} Quality: #{movie.tomatoImage}\n"
          text += "IMDB: #{movie.imdbRating} MS: #{movie.Metascore}\n"
          text += "#{movie.Poster}\n" if movie.Poster
          
          msg.send text
        else
          msg.send "That's not a movie, yo."

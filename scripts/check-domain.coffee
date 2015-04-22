# Description:
#   Check if a domain is available
#
# Commands:
#   hubot check domain <domain name>

punycode = require('punycode')
request  = require('request')

module.exports = (robot) ->

  robot.respond /check domain (.*)/i, (msg) ->
    domain = punycode.toASCII(msg.match[1].trim())

    request "https://domainr.com/#{domain}", (err, resp, body) ->
        if resp.statusCode is 404
          msg.send 'Nope, it does not exist'
          return

        if body.indexOf('status taken') isnt -1
          msg.send 'Taken :('
        if body.indexOf('status registrar') isnt -1
          msg.send 'It is a Registar. Yep this is SWAG.'
        else if body.indexOf('status pending') isnt -1
          msg.send "Coming soon https://domainr.com/?q=#{domain}"
        else if body.indexOf('status available') isnt -1
          msg.send "Available ! GO BUY IT https://domainr.com/?q=#{domain}"
        else if body.indexOf('status unavailable') isnt -1
          msg.send 'Nope, it does not exist'
        else 
          msg.send "Error, check manually https://domainr.com/?q=#{domain} and submit Pull Requests"

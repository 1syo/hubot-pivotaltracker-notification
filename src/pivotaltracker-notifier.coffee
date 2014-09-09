# Description
#   A hubot script that notify about status in Pivotal Tracker
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None
#
# URLS:
#   POST /<hubot>/pivotaltracker/<room>
#
# Notes:
#    See also:
#    http://www.pivotaltracker.com/help/integrations?version=v5#activity_web_hook
#
# Author:
#   TAKAHASHI Kazunari[takahashi@1syo.net]
Postman = require "./postman"
module.exports = (robot) ->
  robot.router.post "/#{robot.name}/pivotaltracker/:room", (req, res) ->
    try
      postman = Postman.create(req, robot)
      postman.notify()
      res.end "[PivotalTracker] Sending message"
    catch e
      res.end "[PivotalTracker] #{e}"

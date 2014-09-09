# Description
#   <description of the scripts functionality>
#
# Dependencies:
#   "<module name>": "<module version>"
#
# Configuration:
#   LIST_OF_ENV_VARS_TO_SET
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   <github username of the original script author>
Postman = require "./postman"
module.exports = (robot) ->
  robot.router.post "/#{robot.name}/pivotaltracker/:room", (req, res) ->
    try
      postman = Postman.create(req, robot)
      if postman.notifirable()
        postman.notify()
        res.end "[PivotalTracker] Sending message"
      else
        res.end ""
    catch e
      res.end "[PivotalTracker] #{e}"

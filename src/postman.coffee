# Description
#
Common = require "./postman/common"
Slack = require "./postman/slack"

class Postman
  @create: (req, robot) ->
    if robot.adapterName == 'slack'
      new Slack(req, robot)
    else
      new Common(req, robot)

module.exports = Postman

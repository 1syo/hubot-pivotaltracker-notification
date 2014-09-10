# Description
#   None
Base = require "./base"
class Slack extends Base
  color: ->
    switch @highlight()
      when "started"
        "#e0e2e5"
      when "finished"
        "#244062"
      when "delivered"
        "#f39300"
      when "accepted"
        "#649012"
      when "rejected"
        "#a3243d"

  pretext: ->
    "[PivotalTracker] #{@project_name()}: #{@message()} ( #{@url()}|##{@id()} )"

  text: ->
    @story_name()

  payload: ->
    message:
      room: @room()
    content:
      text: @text()
      pretext: @pretext()
      color: @color()
      fallback: @notice()

  notify: ->
    @robot.emit 'slack-attachment', @payload()

module.exports = Slack

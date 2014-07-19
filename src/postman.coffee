# Description
#   <description of the scripts functionality>
#
_ = require "underscore"

class Base
  constructor: (req, @robot) ->
    @_room = req.params.room
    @json = req.body

  room: ->
    @_room || ""

  project_id: ->
    @json["primary_resources"][0]["id"]

  project_name: ->
    @json["project"]["name"]

  state: ->
    capitalize.call(@, @json["highlight"])

  owners: ->
    capitalize.call(@, @json["performed_by"]["name"])

  url: ->
    @json["primary_resources"][0]["url"]

  story_type: ->
    capitalize.call(@, @json["primary_resources"][0]["story_type"])

  story_name: ->
    @json["primary_resources"][0]["name"]

  kind: ->
    if @json == {}
      ""
    else
      @json["kind"]

  deliverable:->
    this.kind() == "story_update_activity"

  capitalize = (word) ->
    word.charAt(0).toUpperCase() + word.slice 1


class Common extends Base
  text: ->
    """
      [PivotalTracker] #{this.story_name()} (#{this.project_id()})
      Project: #{this.project_name()}
      Type: #{this.story_type()}
      State: #{this.state()}
      Owners: #{this.owners()}
      #{this.url()}
    """

  deliver: ->
    @robot.send {room: this.room()}, this.text()


class Slack extends Base
  color: ->
    switch @json["highlight"]
      when "started"
        "#e0e2e5"
      when "finished"
        "#244062"
      when "delivered"
        "#f39300"
      when "accepted"
        "#649012"
      when "rejected"
        "#A3243D"

  text: ->
    "[PivotalTracker] #{this.story_name()} (#{this.url()}|#{this.project_id()})"

  payload: ->
    message:
      room: this.room()
    content:
      pretext: this.text()
      text: ""
      color: this.color()
      fallback: ""
      fields: [
        {title: "Project", value: this.project_name(), short: true}
        {title: "Type", value: this.story_type(), short: true}
        {title: "State", value: this.state(), short: true}
        {title: "Owners", value: this.owners(), short: true}
      ]

  deliver: ->
    @robot.emit 'slack-attachment', this.payload()


class Postman
  @create: (req, robot) ->
    if robot.adapterName == 'slack'
      new Slack(req, robot)
    else
      new Common(req, robot)


module.exports = Postman

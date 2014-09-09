# Description
#
class Base
  constructor: (@req, @robot) ->
    @json = @req.body

  room: ->
    @req.params.room || ""

  story_name: ->
    @json["primary_resources"][0]["name"]

  url: ->
    @json["primary_resources"][0]["url"]

  project_name: ->
    @json.project.name

  message: ->
    @json.message

  notice: ->
    "[PivotalTracker][#{@project_name()}] #{@message()}: #{@story_name()} (#{@url()})"

module.exports = Base

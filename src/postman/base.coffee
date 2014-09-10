# Description
#   None
class Base
  constructor: (@req, @robot) ->
    @json = @req.body

  room: ->
    @req.params.room || ""

  id: ->
    @json["primary_resources"][0]["id"]

  story_name: ->
    @json["primary_resources"][0]["name"]

  url: ->
    @json["primary_resources"][0]["url"]

  project_name: ->
    @json.project.name

  message: ->
    @json.message

  highlight: ->
    @json.highlight

  short_story_name: ->
    if @story_name().length > 20
      "#{@story_name().substr(0, 20)}..."
    else
      @story_name()

  notice: ->
    "[PivotalTracker] #{@project_name()}: #{@message()} - #{@short_story_name()} (#{@url()})"

module.exports = Base

chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect

Postman = require '../src/postman'

valid_json = require './fixtures/valid.json'

describe 'Postman', ->
  beforeEach ->
    @req =
      body: valid_json
      params:
        room: "general"

  describe 'Common', ->
    beforeEach ->
      @robot =
        adapterName: "shell"
        send: sinon.spy()

      @postman = Postman.create(@req, @robot)

    it '#room', ->
      expect(@postman.room()).to.eq "general"

    it '#project_name', ->
      expect(@postman.project_name()).to.eq "Death Star"

    it '#state', ->
      expect(@postman.state()).to.eq "Accepted"

    it '#owners', ->
      expect(@postman.owners()).to.eq "Darth Vader"

    it '#url', ->
      expect(@postman.url()).to.eq "http://story/show/563"

    it '#story_type', ->
      expect(@postman.story_type()).to.eq "Feature"

    it '#story_name', ->
      expect(@postman.story_name()).to.eq "Reactor leak reported in Detention Block AA-23"

    it '#kind', ->
      expect(@postman.kind()).to.eq "story_update_activity"

    it '#deliverable', ->
      expect(@postman.deliverable()).to.eq true

    it '#text', ->
      expect(@postman.text()).to.eq """
        [PivotalTracker] Reactor leak reported in Detention Block AA-23 (563)
        Project: Death Star
        Type: Feature
        State: Accepted
        Owners: Darth Vader
        http://story/show/563
      """

    it "#deliver", ->
      @postman.deliver()
      expect(@robot.send).to.have.been.calledWith(
        {room: @postman.room()}, @postman.text()
      )

  describe 'Slack', ->
    beforeEach ->
      @robot =
        adapterName: "slack"
        emit: sinon.spy()

      @postman = Postman.create(@req, @robot)

    it '#color', ->
      expect(@postman.color()).to.eq "#649012"

    it '#text', ->
      expect(@postman.text()).to.eq "[PivotalTracker] Reactor leak reported in Detention Block AA-23 (http://story/show/563|563)"

    it '#payload', ->
      expect(@postman.payload().message["room"]).to.eq "general"
      expect(@postman.payload().content["pretext"]).to.eq @postman.text()
      expect(@postman.payload().content["color"]).to.eq "#649012"

    it "#deliver", ->
      @postman.deliver()
      expect(@robot.emit).to.have.been.calledWith(
        'slack-attachment', @postman.payload()
      )

chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect

Slack = require '../../src/postman/slack'

describe 'Slack', ->
  describe '#color', ->
    it 'started', ->
      @req = { body: { highlight: "started" } }
      @postman = new Slack(@req, {})
      expect(@postman.color()).to.eq "#e0e2e5"

    it 'finished', ->
      @req = { body: { highlight: "finished" } }
      @postman = new Slack(@req, {})
      expect(@postman.color()).to.eq "#244062"

    it 'delivered', ->
      @req = { body: { highlight: "delivered" } }
      @postman = new Slack(@req, {})
      expect(@postman.color()).to.eq "#f39300"

    it 'accepted', ->
      @req = { body: { highlight: "accepted" } }
      @postman = new Slack(@req, {})
      expect(@postman.color()).to.eq "#649012"

    it 'rejected', ->
      @req = { body: { highlight: "rejected" } }
      @postman = new Slack(@req, {})
      expect(@postman.color()).to.eq "#a3243d"

  describe '#pretext', ->
    beforeEach ->
      @req =
        params:
          room: 'general'
        body:
          message: 'Darth Vader accepted this feature'
          primary_resources: [
            id: 1
            name: 'Never ending story'
            url: 'http://example.com/'
          ]
          project:
            name: 'Project X'
      @postman = new Slack(@req, {})

    it 'should be pretext format', ->
      expect(@postman.pretext()).to.eq """
        [PivotalTracker] Project X: Darth Vader accepted this feature ( http://example.com/|#1 )
        """

  describe '#payload', ->
    beforeEach ->
      @req =
        params:
          room: 'general'
        body:
          highlight: "started"
          message: 'Darth Vader accepted this feature'
          primary_resources: [
            id: 1
            name: 'Never ending story'
            url: 'http://example.com/'
          ]
          project:
            name: 'Project X'
      @postman = new Slack(@req, {})

    it '.message.room', ->
      expect(@postman.payload().message.room).to.eq "general"

    it '.content.pretext', ->
      expect(@postman.payload().content.pretext).to.eq @postman.pretext()

    it '.content.text', ->
      expect(@postman.payload().content.text).to.eq @postman.text()

    it '.content.color', ->
      expect(@postman.payload().content.color).to.eq "#e0e2e5"

    it '.content.fallback', ->
      expect(@postman.payload().content.fallback).to.eq @postman.notice()

  describe '#notify', ->
    beforeEach ->
      @req =
        params:
          room: 'general'
        body:
          highlight: "started"
          message: 'Darth Vader accepted this feature'
          primary_resources: [
            name: 'Never ending story'
            url: 'http://example.com/'
          ]
          project:
            name: 'Project X'
      @robot = { emit: sinon.spy() }
      @postman = new Slack(@req, @robot)
      @postman.notify()

    it "should call @robot#emi with args", ->
      @postman.notify()
      expect(@robot.emit).to.have.been.calledWith(
        'slack-attachment', @postman.payload()
      )

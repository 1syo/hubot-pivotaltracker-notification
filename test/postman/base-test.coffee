chai = require 'chai'
expect = chai.expect

Base = require '../../src/postman/base'

describe 'Base', ->

  describe '#room', ->
    beforeEach ->
      @req = { params: { room: "general" } }
      @postman = new Base(@req, {})

    it 'should be general', ->
      expect(@postman.room()).to.eq "general"

  describe '#story_name', ->
    beforeEach ->
      @req = { body: { primary_resources: [ name: 'Never ending story'] } }
      @postman = new Base(@req, {})

    it 'should be Never ending story', ->
      expect(@postman.story_name()).to.eq "Never ending story"

  describe '#url', ->
    beforeEach ->
      @req = { body: { primary_resources: [ url: 'http://example.com/'] } }
      @postman = new Base(@req, {})

    it 'should be http://example.com/', ->
      expect(@postman.url()).to.eq "http://example.com/"

  describe '#project_name', ->
    beforeEach ->
      @req = { body: { project: { name: 'Project X' } } }
      @postman = new Base(@req, {})

    it 'should be Project X', ->
      expect(@postman.project_name()).to.eq "Project X"

  describe '#message', ->
    beforeEach ->
      @req = { body: { message: 'Darth Vader accepted this feature' } }
      @postman = new Base(@req, {})

    it 'should be Darth Vader accepted this feature', ->
      expect(@postman.message()).to.eq "Darth Vader accepted this feature"

  describe '#notice', ->
    beforeEach ->
      @req =
        body:
          message: 'Darth Vader accepted this feature'
          primary_resources: [
            name: 'Never ending story'
            url: 'http://example.com/'
          ]
          project:
            name: 'Project X'
      @postman = new Base(@req, {})

    it 'should be notice format', ->
      expect(@postman.notice()).to.eq """
        [PivotalTracker] Project X: Darth Vader accepted this feature - Never ending story (http://example.com/)
        """

chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'
expect = chai.expect

Common = require '../../src/postman/common'

describe 'Common', ->
  beforeEach ->
    @req =
      params:
        room: 'general'
      body:
        message: 'Darth Vader accepted this feature'
        primary_resources: [
          name: 'Never ending story'
          url: 'http://example.com/'
        ]
        project:
          name: 'Project X'
    @robot = { send: sinon.spy() }
    @postman = new Common(@req, @robot)
    @postman.notify()

  it "#notify", ->
    expect(@robot.send).to.have.been.calledWith(
      {room: @postman.room()}, @postman.notice()
    )

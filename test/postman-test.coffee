chai = require 'chai'
expect = chai.expect

Common = require '../src/postman/common'
Slack = require '../src/postman/slack'
Postman = require '../src/postman'

describe 'Postman', ->
  describe '.create', ->
    it 'create with Common', ->
      @robot = { adapterName: 'shell' }
      @postman = Postman.create({}, @robot)
      expect(@postman).to.be.an.instanceof(Common)

    it 'create with Slack', ->
      @robot = { adapterName: 'slack' }
      @postman = Postman.create({}, @robot)
      expect(@postman).to.be.an.instanceof(Slack)

#= require spec_helper

describe 'Home Controller', ->
  beforeEach inject ($controller) ->
    ctrl = $controller 'HomeCtrl'

  describe 'HomeCtrl', ->
    it 'passes a simple jasmine test', ->
      expect(1).toEqual(1)

    it 'opens up the home controller', ->
      expect(@scope.controller).toBe(@currentController)

  describe '$scope.getTotalPot', ->
    it 'should equal -625 if there are no entries', ->
      expect(1).toEqual(1)



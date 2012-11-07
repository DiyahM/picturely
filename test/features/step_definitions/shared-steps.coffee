Browser = require 'zombie'
SharedSteps = ->
  
  this.Before (callback) ->
    this.app = require('../../../server')
    this.browser = new Browser()
    callback()

  this.Given 'I am on the home page', (callback) ->
    this.browser.visit('http://localhost:3000', callback)
  
module.exports = SharedSteps

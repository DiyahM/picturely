should = require 'should'
Search= ->

  this.When /^I search for (\w+.*)$/, (keyword, callback) ->
    this.browser.fill "q", keyword
    this.browser.pressButton "Search", callback

  this.Then /^I should see pictures about (\w+.*)$/, (keyword, callback) ->
    this.browser.html("#results").should.include('img')
    this.browser.html("#results .tweet .text").should.include(keyword)
    callback()

module.exports = Search


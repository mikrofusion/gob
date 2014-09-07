readline = require 'readline'
util = require 'util'
breakwrap = require('breakwrap')

moveCursor = (x, y) ->
  if process.env.NODE_ENV == 'TEST'
    exports.moveCursorX = x
    exports.moveCursorY = y
  else
    readline.moveCursor(process.stdin, x, y)

clearScreenDown = ->
  if process.env.NODE_ENV == 'TEST'
    exports.clearScreenDownCalled = true
  else
    readline.clearScreenDown(process.stdin)

class Gob
  _lines = 0

  constructor: (output) ->
    throw new Error 'gob requires an output stream.' if not output?


    output._gobOriginalWrite = output.write
    output.write = (args...) ->
      count = args[0].split('\n').length - 1
      _lines += count
      output._gobOriginalWrite args...

    breakwrap output

  set: -> _lines = 0

  vanish: ->
    if _lines?
      moveCursor(0, -_lines)
      clearScreenDown()
    @set()

  _lines: -> _lines

exports.gob = (output) ->
  if process.env.NODE_ENV == 'TEST'
    exports.clearScreenDownCalled = undefined
    exports.moveCursorX = undefined
    exports.moveCursorY = undefined
  new Gob(output)


readline = require 'readline'
util = require 'util'

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

    output._originalWrite = output.write
    output.write = (args...) ->
      count = args[0].split('\n').length - 1
      _lines += count
      output._originalWrite args...

  reset: -> _lines = 0

  vanish: ->
    if _lines?
      moveCursor(0, -_lines)
      clearScreenDown()
    @reset()

  _lines: -> _lines

exports.gob = (output) ->
  if process.env.NODE_ENV == 'TEST'
    exports.clearScreenDownCalled = undefined
    exports.moveCursorX = undefined
    exports.moveCursorY = undefined
  new Gob(output)


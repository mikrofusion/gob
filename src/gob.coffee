readline = require 'readline'
util = require 'util'

moveCursor = (x, y) -> readline.moveCursor(process.stdin, x, y)
clearScreenDown = -> readline.clearScreenDown(process.stdin)

_lines = 0
_initialized = false

shimOutput = (output) ->
  output._originalWrite = output.write
  output.write = (args...) ->
    count = args[0].split('\n').length - 1
    _lines += count
    output._originalWrite args...

exports.init = (output) ->
  _initialized = true
  shimOutput output

exports.reset = () ->
  _lines = 0

exports.vanish = ->
  throw new Error '' if not _initialized?
  if _lines?
    moveCursor(0, -_lines)
    clearScreenDown()
  exports.reset()


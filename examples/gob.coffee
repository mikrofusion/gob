gob = require('../dist/index.js')

gob.init(process.stdout)

readline = require 'readline'

rl = readline.createInterface(process.stdin, process.stdout)

rl.setPrompt 'gob> '
rl.prompt()

rl.on('line', (line) ->
  if line.trim() == 'clear'
    gob.vanish()
  rl.prompt()
).on 'close', ->
  process.exit 0

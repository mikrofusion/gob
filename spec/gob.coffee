Gob = require '../dist/index.js'

expect = require('chai').expect
sinon = require 'sinon'

describe 'Gob', ->
  describe 'when given an output stream', ->
    output = undefined
    gob = undefined

    before ->
      output = { write: () -> }
      gob = Gob.gob(output)

    describe 'when writing to the output stream', ->
      before ->
        output.write '\n\n\n\n'
        output.write ''
        output.write '\n'

      it 'keeps track of the number of newlines written', ->
        expect(gob._lines()).to.eq 5

    describe 'reset', ->
      before ->
        output.write '\n\n\n\n'
        gob.reset()

      it 'sets the number of lines to 0', ->
        expect(gob._lines()).to.eq 0

    describe 'vanish', ->
      clearScreen = undefined
      before ->
        output.write '\n\n\n\n'
        gob.vanish()

      it 'moves the cursor back', ->
        expect(Gob.moveCursorX).to.eq 0
        expect(Gob.moveCursorY).to.eq -4

      it 'clears the screen down', ->
        expect(Gob.clearScreenDownCalled).to.eq true



  describe 'when NOT given an output stream', ->
    it 'throws an error when NOT given an output stream', ->
      expect(-> Gob.gob()).to.throw('gob requires an output stream.')

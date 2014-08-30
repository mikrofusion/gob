gob = require('../dist/index.js').gob(process.stdout)

console.log 'foo'
console.log 'bar'

gob.set()

console.log 'erase me 1'
console.log 'erase me 2'
console.log 'erase me 3'

gob.vanish()

console.log 'biz'
console.log 'baz'

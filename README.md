# gob

[![NPM](https://nodei.co/npm/gob.png)](https://nodei.co/npm/gob/)

[![NPM version][npm-image]][npm-url] [![Build Status][travis-image]][travis-url]

gob (aka G.O.B) magically vanishes lines from your output stream.


![GOB](../images/gob.jpg?raw=true)

## Install

```bash
$ npm install gob
```

## Use

gob requires an output stream (such as process.stdout).

```
gob = require('gob').gob(process.stdout)
```

Call ``` vanish ``` to magically remove the output stream of any lines previously written.

```
gob.vanish()
```

To indicate that only lines after a certain point should disappear, use ``` set ```.

```
gob.set()
```

## Examples

```
gob = require('gob').gob(process.stdout)

console.log 'foo'
console.log 'bar'

gob.set()

console.log 'erase me 1'
console.log 'erase me 2'
console.log 'erase me 3'

gob.vanish()

console.log 'biz'
console.log 'baz'

```

Creates the following output:
```
foo
bar
biz
baz
```

Additional examples are included in the examples folder.

The examples can be ran via the following (replace <example> with the name of the example).

```
gulp compile && coffee examples/<example>.coffee --n
```

## License

[MIT](http://opensource.org/licenses/MIT) © Mike Groseclose

[npm-url]: https://npmjs.org/package/gob
[npm-image]: https://badge.fury.io/js/gob.png

[travis-url]: http://travis-ci.org/mikegroseclose/gob
[travis-image]: https://secure.travis-ci.org/mikegroseclose/gob.png?branch=master

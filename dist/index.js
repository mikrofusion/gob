var Gob, clearScreenDown, moveCursor, readline, util,
  __slice = [].slice;

readline = require('readline');

util = require('util');

moveCursor = function(x, y) {
  if (process.env.NODE_ENV === 'TEST') {
    exports.moveCursorX = x;
    return exports.moveCursorY = y;
  } else {
    return readline.moveCursor(process.stdin, x, y);
  }
};

clearScreenDown = function() {
  if (process.env.NODE_ENV === 'TEST') {
    return exports.clearScreenDownCalled = true;
  } else {
    return readline.clearScreenDown(process.stdin);
  }
};

Gob = (function() {
  var _lines;

  _lines = 0;

  function Gob(output) {
    if (output == null) {
      throw new Error('gob requires an output stream.');
    }
    output._originalWrite = output.write;
    output.write = function() {
      var args, count;
      args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      count = args[0].split('\n').length - 1;
      _lines += count;
      return output._originalWrite.apply(output, args);
    };
  }

  Gob.prototype.reset = function() {
    return _lines = 0;
  };

  Gob.prototype.vanish = function() {
    if (_lines != null) {
      moveCursor(0, -_lines);
      clearScreenDown();
    }
    return this.reset();
  };

  Gob.prototype._lines = function() {
    return _lines;
  };

  return Gob;

})();

exports.gob = function(output) {
  if (process.env.NODE_ENV === 'TEST') {
    exports.clearScreenDownCalled = void 0;
    exports.moveCursorX = void 0;
    exports.moveCursorY = void 0;
  }
  return new Gob(output);
};

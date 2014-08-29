var clearScreenDown, moveCursor, readline, shimOutput, util, _initialized, _lines,
  __slice = [].slice;

readline = require('readline');

util = require('util');

moveCursor = function(x, y) {
  return readline.moveCursor(process.stdin, x, y);
};

clearScreenDown = function() {
  return readline.clearScreenDown(process.stdin);
};

_lines = 0;

_initialized = false;

shimOutput = function(output) {
  output._originalWrite = output.write;
  return output.write = function() {
    var args, count;
    args = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
    count = args[0].split('\n').length - 1;
    _lines += count;
    return output._originalWrite.apply(output, args);
  };
};

exports.init = function(output) {
  _initialized = true;
  return shimOutput(output);
};

exports.reset = function() {
  return _lines = 0;
};

exports.vanish = function() {
  if (_initialized == null) {
    throw new Error('');
  }
  if (_lines != null) {
    moveCursor(0, -_lines);
    clearScreenDown();
  }
  return exports.reset();
};

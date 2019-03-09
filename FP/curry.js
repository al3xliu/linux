/* global __dirname */
/* global process */
/*jshint esversion: 6 */
'use strict';

var _ = require('ramda');
var curry = require('lodash').curry;

var match = curry(function(what, str) {
  return str.match(what);
})

/*
var match = function(str) {
  return function(what) {
    return str.match(what);
  }
}
*/

var words = function(str) {
  return split(' ', str);
};

var words = curry(function(char , str) {
  return str.split(char);
})

var words = function(str) {
  return function(char) {
    return str.split(char)
  }
}

var _keepHighest = function(x,y){ return x >= y ? x : y; };

var _keepHighest = function(x) {
  return function(y) {
    if (x >= y) {
      return x;
    }
    return y;
  }
}
console.log(match('test'))

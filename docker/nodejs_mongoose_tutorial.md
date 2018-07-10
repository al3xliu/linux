# Nodejs

npm install mongoose
reference: https://www.npmjs.com/package/mongoose
http://mongoosejs.com/docs/


## Code

```js
/* global __dirname */
/* global process */
'use strict';

var express = require('express');
var app = express();
var mongoose = require('mongoose');

/* #######################################
  Mongo Part
######################################## */
mongoose.connect('mongodb://localhost:27017/test');
// When successfully connected
mongoose.connection.on('connected', function () {
  console.log('Mongoose connect successfully');
});

// If the connection throws an error
mongoose.connection.on('error',function (err) {
  console.log('Mongoose default connection error: ' + err.message);
});

// When the connection is disconnected
mongoose.connection.on('disconnected', function () {
  console.log('Mongoose default connection disconnected');
});

var Schema = mongoose.Schema;

var userSchema = new Schema({
  name: String,
  username: { type: String, required: true, unique: true },
  password: { type: String, required: true },
  admin: Boolean,
  location: String,
  meta: {
    age: Number,
    website: String
  },
  created_at: Date,
  updated_at: Date
});

var User = mongoose.model('User', userSchema);
var cindy = new User({
  name: 'Cindy',
  username: 'sevilayha',
  password: 'password'
});

cindy.save(function(err) {
  if (err) throw err;

  console.log('User saved successfully!');
});



/* #######################################
  Server Part
######################################## */

app.get('/', function (req, res) {
   res.send('Hello World');
})

var server = app.listen(8081, function () {
   var host = server.address().address
   var port = server.address().port
})

```

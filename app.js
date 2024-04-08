var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
const { expressjwt: jwt } = require("express-jwt");
require('dotenv').config();

const privateKey = process.env.PRIVATE_KEY;

var loginRouter = require('./routes/login');
var signupRouter = require('./routes/signup');
var messagesRouter = require('./routes/messages');

var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'pug');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

// Middleware for JWT authentication
app.use(
    jwt({
      secret: privateKey,
      algorithms: ["HS256"],
    }).unless({ path: ["/login","/signup"] })
);

app.use('/login', loginRouter);
app.use('/signup', signupRouter);
app.use('/messages', messagesRouter);

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);
  res.render('error');
});

module.exports = app;

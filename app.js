var createError = require('http-errors');
var express = require('express');
const cors = require('cors');
const rateLimit = require('express-rate-limit');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

require('dotenv').config();

const { expressjwt: jwt } = require("express-jwt");
const privateKey = process.env.PRIVATE_KEY;

var loginRouter = require('./routes/login');
var signupRouter = require('./routes/signup');
var tokenRouter = require('./routes/token');
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

// Limiter le nombre de requêtes par IP
app.use(rateLimit({
    windowMs: 60 * 1000, // 1 minute
    limit: 100,
    standardHeaders: 'draft-7', // draft-6: `RateLimit-*` headers; draft-7: combined `RateLimit` header
    legacyHeaders: false, // Disable the `X-RateLimit-*` headers.
}));

// Utilisez CORS comme middleware
app.use(cors({
    // origin: 'http://localhost:3000',
    origin: '*',
    methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
    preflightContinue: false,
    optionsSuccessStatus: 204
}));

// Middleware for JWT authentication
app.use(
    jwt({
      secret: privateKey,
      algorithms: ["RS256"],
    }).unless({ path: ["/login/","/signup/","/token/refresh"] })
);

app.use('/login', loginRouter);
app.use('/signup', signupRouter);
app.use('/token', tokenRouter);
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

const express = require('express');
const router = express.Router();

const { refresh } = require('../services/token');

router.get('/refresh', refresh);

module.exports = router;

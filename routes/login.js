const express = require('express');
const router = express.Router();
const login = require('../services/login');


router.post('/', async function (req, res, next) {
    const { mail, password } = req.body;
    try {
        const loginResult = await login.getLogin(mail, password);
        res.json(loginResult);
    } catch (err) {
        console.error(`Error while logging in`, err.message);
        next(err);
    }
});


module.exports = router;
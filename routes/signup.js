const express = require('express');
const router = express.Router();
const signUpService = require('../services/signup');

router.post('/', async function (req, res, next) {
    const { mail, password, username, name, surname, pp_url } = req.body;
    console.dir(req.body);
    console.log("zero : "+mail)
    try {
        // Call signUpService method to handle signup logic
        const signUpResult = await signUpService.signUp(mail, password, username, name, surname, pp_url);
        res.json(signUpResult);
    } catch (err) {
        console.error(`Error while signing up`, err.message);
        next(err);
    }
});

module.exports = router;

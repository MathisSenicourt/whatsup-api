const db = require('./db');
const { generateAccessToken, generateRefreshToken } = require('./token');
const bcrypt = require('bcrypt');

async function signUp(mail, password, username, name, surname, pp_url) {
    try {
        // Check if the email is already registered
        console.log("first : "+mail);
        const existingUser = await db.query('SELECT * FROM login WHERE mail = ?', [mail]);
        if (existingUser.length > 0) {
            throw new Error('Email already registered');
        }
        const hashedPassword = await bcrypt.hash(password, 10)
        // If the email is not registered, insert the new user details into the database
        await db.query('INSERT INTO login (mail, password) VALUES (?, ?)', [mail, hashedPassword]);
        await db.query('INSERT INTO account (mail, username, name, surname, pp_url) VALUES (?, ?, ?, ?, ?)', [mail, username, name, surname, pp_url]);

        // Generate access token and refresh token
        const accessToken = generateAccessToken(mail);
        const refreshToken = generateRefreshToken(mail);

        return { accessToken, refreshToken };
    } catch (error) {
        throw error;
    }
}

module.exports = {
    signUp
};

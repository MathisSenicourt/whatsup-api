const db = require('./db');
const { generateAccessToken, generateRefreshToken } = require('./token');

async function signUp(mail, password, username, name, surname, pp_url) {
    const client = await db.connect();
    try {
        // Check if the email is already registered
        const existingUser = await client.query('SELECT * FROM login WHERE mail = $1', [mail]);
        if (existingUser.rows.length > 0) {
            throw new Error('Email already registered');
        }

        // If the email is not registered, insert the new user details into the database
        await client.query('INSERT INTO login (mail, password) VALUES ($1, $2)', [mail, password]);
        await client.query('INSERT INTO account (mail, username, name, surname, pp_url) VALUES ($1, $2, $3, $4, $5)', [mail, username, name, surname, pp_url]);

        // Generate access token and refresh token
        const accessToken = generateAccessToken(mail);
        const refreshToken = generateRefreshToken(mail);

        return { accessToken, refreshToken };
    } catch (error) {
        throw error;
    } finally {
        client.release();
    }
}

module.exports = {
    signUp
};

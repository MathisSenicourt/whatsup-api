const jwt = require('jsonwebtoken');
require('dotenv').config();

// Fonction pour générer un access token
function generateAccessToken(mail) {
    return jwt.sign({ mail }, process.env.PRIVATE_KEY, { expiresIn: '15m' });
}

// Fonction pour générer un refresh token
function generateRefreshToken(mail) {
    return jwt.sign({ mail }, process.env.PRIVATE_KEY, { expiresIn: '72h' });
}

module.exports = {
    generateAccessToken,
    generateRefreshToken
};

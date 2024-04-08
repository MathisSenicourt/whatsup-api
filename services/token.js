const jwt = require('jsonwebtoken');

// Fonction pour générer un access token
function generateAccessToken(mail) {
    return jwt.sign({ mail }, process.env.ACCESS_TOKEN_SECRET, { expiresIn: '15m' });
}

// Fonction pour générer un refresh token
function generateRefreshToken(mail) {
    return jwt.sign({ mail }, process.env.REFRESH_TOKEN_SECRET, { expiresIn: '72h' });
}

module.exports = {
    generateAccessToken,
    generateRefreshToken
};

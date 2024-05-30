const db = require('./db');
const {generateAccessToken, generateRefreshToken} = require('./token');
const bcrypt = require("bcrypt");

// Fonction pour obtenir les informations de connexion
async function getLogin(mail, password) {
    try {
        // Vérifier les informations de connexion dans la base de données
        const queryResult = await db.query('SELECT password FROM login WHERE mail = ?', [mail]);
        const bcryptResult = await bcrypt.compare(password, queryResult[0].password);
        console.log("queryResult = "+ queryResult)
        console.log("bcryptResult = "+ bcryptResult)
        console.log("password = "+ password)
        console.log("queryResult[0] = "+ queryResult[0])
        console.log("queryResult[0].password = "+ queryResult[0].password)

        if (bcryptResult) {
            // Si les informations de connexion sont valides, générer les tokens
            const accessToken = generateAccessToken(mail);
            const refreshToken = generateRefreshToken(mail);
            return {accessToken, refreshToken};
        }
        throw new Error('Invalid email or password');
    } catch
        (error) {
        throw error;
    }
}

module.exports = {
    getLogin
};

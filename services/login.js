const db = require('./db');
const { generateAccessToken, generateRefreshToken } = require('./token');
const bcrypt = require("bcrypt");

// Fonction pour obtenir les informations de connexion
async function getLogin(mail, password) {
    const client = await db.connect();
    try {
        const hashedPassword = await bcrypt.hash(password, 10)
        // Vérifier les informations de connexion dans la base de données
        const queryResult = await client.query('SELECT * FROM login WHERE mail = $1 AND password = $2', [mail, hashedPassword]);

        if (queryResult.rows.length === 0) {
            throw new Error('Invalid email or password');
        }

        // Si les informations de connexion sont valides, générer les tokens
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
    getLogin
};

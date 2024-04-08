const db = require('./db');

// async function sendMessage(sender, receiver, content) {
//     try {
//         // Vérifier si l'utilisateur émetteur et le destinataire existent dans la base de données
//         const checkUsersQuery = 'SELECT COUNT(*) FROM login WHERE mail = $1 OR mail = $2';
//         const usersExist = await db.query(checkUsersQuery, [sender, receiver]);
//         if (usersExist.rows[0].count !== '2') {
//             throw new Error('Sender or receiver does not exist');
//         }
//
//         // Enregistrer le message dans la base de données
//         const insertMessageQuery = 'INSERT INTO messages (sender, receiver, content) VALUES ($1, $2, $3)';
//         await db.query(insertMessageQuery, [sender, receiver, content]);
//
//         return {message: 'Message sent successfully'};
//     } catch (error) {
//         throw error;
//     }
// }

async function getRecentConversations(userMail) {
    try {
        // Sélectionner les conversations récentes de l'utilisateur
        const query = `
            SELECT CASE
                       WHEN m.sender = $1 THEN m.receiver
                       ELSE m.sender
                       END AS conversation_partner,
                   m.content,
                   m.date
            FROM messages m
            WHERE (m.sender = $1 OR m.receiver = $1)
              AND (m.date, m.id) = (SELECT MAX(date),
                                           MAX(id)
                                    FROM messages
                                    WHERE (sender = m.sender AND receiver = m.receiver)
                                       OR (sender = m.receiver AND receiver = m.sender));
            ;
        `;
        const result = await db.query(query, [userMail]);

        const conversations = result.rows.map(row => {
            return {
                partner: row.conversation_partner,
                message: row.content,
                date: row.date
            };
        });

        return conversations;
    } catch (error) {
        throw error;
    }
}

async function getConversation(user1, user2) {
    try {
        const query = `
            SELECT sender, receiver, content, date
            FROM messages
            WHERE (sender = $1 AND receiver = $2)
               OR (sender = $2 AND receiver = $1)
            ORDER BY date;
        `;
        const result = await db.query(query, [user1, user2]);
        return result.rows;
    } catch (error) {
        throw error;
    }
}

module.exports = {
    // sendMessage,
    getRecentConversations,
    getConversation
};


const express = require('express');
const router = express.Router();
const messageService = require('../services/messages');

// // Route pour sauvegarder/envoyer un message
// router.post('/send-message', async function (req, res, next) {
//     const {sender, receiver, content} = req.body;
//     try {
//         const result = await messageService.sendMessage(sender, receiver, content);
//         res.json(result);
//     } catch (error) {
//         console.error('Error sending message:', error);
//         res.status(500).json({error: 'An error occurred while sending the message'});
//     }
// });

// Route pour récupérer la liste des conversations récentes de l'utilisateur
router.get('/recent-conversations/:userMail', async function (req, res, next) {
    const userMail = req.params.userMail;
    try {
        const conversations = await messageService.getRecentConversations(userMail);
        res.json(conversations);
    } catch (error) {
        console.error('Error retrieving recent conversations:', error);
        res.status(500).json({error: 'An error occurred while retrieving recent conversations'});
    }
});

// Route pour récupérer toute la conversation entre deux utilisateurs
router.get('/conversation/:user1/:user2', async function (req, res, next) {
    const user1 = req.params.user1;
    const user2 = req.params.user2;
    try {
        const conversation = await messageService.getConversation(user1, user2);
        res.json(conversation);
    } catch (error) {
        console.error('Error retrieving conversation:', error);
        res.status(500).json({error: 'An error occurred while retrieving the conversation'});
    }
});

module.exports = router;

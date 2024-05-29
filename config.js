const config = {
    db: {
        host: "localhost",
        user: "root",
        // password: "root",
        // password: "admin",
        password: process.env.DB_PASSWORD,
        database: "whatsup",
    },
    listPerPage: 10,
};
module.exports = config;
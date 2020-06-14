const Sequelize = require("sequelize");
const config = require('dotenv').config();

const sequelize = new Sequelize(process.env.dbName, process.env.dbUser, process.env.dbPassword, {
  host: process.env.dbHost,
  dialect: process.env.dbDialect,
  pool: {
    max: parseInt(process.env.dbPoolMax),
    min: parseInt(process.env.dbPoolMin),
    acquire: parseInt(process.env.dbPoolAcquire),
    idle: parseInt(process.env.dbPoolIdle)
  }
});

const db = {};

db.Sequelize = Sequelize;
db.sequelize = sequelize;

db.produtos = require("./produto.model.js")(sequelize, Sequelize);

module.exports = db;
module.exports = {
    HOST: "localhost",
    USER: "conchayorouser",
    PASSWORD: "conchayoropwd",
    DB: "conchayorodb",
    dialect: "postgres",
    pool: {
      max: 5,
      min: 0,
      acquire: 30000,
      idle: 10000
    }
  };

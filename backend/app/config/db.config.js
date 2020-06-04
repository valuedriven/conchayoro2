module.exports = {
    HOST: "localhost",
    USER: "tutorial_user",
    PASSWORD: "tutorial_pwd",
    DB: "tutorialdb",
    dialect: "postgres",
    pool: {
      max: 5,
      min: 0,
      acquire: 30000,
      idle: 10000
    }
  };
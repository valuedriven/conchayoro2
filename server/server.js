const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors"); // Express module
const db = require("./src/models");
const config = require('dotenv').config();
const app = express();

var corsOptions = {
  origin: `http://${process.env.corsHost}:${process.env.corsPort}`
};

app.use(cors(corsOptions));

// parse requests of content-type - application/json
app.use(bodyParser.json());

// parse requests of content-type - application/x-www-form-urlencoded
// app.use(bodyParser.urlencoded({ extended: true }));

db.sequelize.sync();

// simple route
app.get("/", (req, res) => {
  res.json({ message: "Bem-vindo(a) a ConchayOro!" });
});

// set port, listen for requests
require("./src/routes/produto.routes")(app);
app.listen(process.env.port, process.env.host, () => {
  console.log(`Server is running on port ${process.env.port}`);
});

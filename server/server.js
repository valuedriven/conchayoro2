console.log("Inicializando servidor...")

const envpath = process.env.NODE_ENV === undefined  ? '.env.development' : `.env.${process.env.NODE_ENV}`;

require('dotenv').config({  
  path: envpath
})

const express = require("express");
const bodyParser = require("body-parser");
const cors = require("cors");
const db = require("./src/models");

const app = express();

app.use(cors());

//Configuração do CORS para restringir acesso a API rest
// var corsOptions = {
//   origin: `http://${process.env.CORS_HOST}:${process.env.CORS_PORT}`
// };
// app.use(cors(corsOptions));

// parse requests of content-type - application/json
app.use(bodyParser.json());

// parse requests of content-type - application/x-www-form-urlencoded
app.use(bodyParser.urlencoded({ extended: true }));

db.sequelize.sync();

// simple route
app.get("/", (req, res) => {
  res.json({ message: "Bem-vindo(a) ao backend do ConchayOro!" });
});

require("./src/routes/produto.routes")(app);

// set port, listen for requests
app.listen(process.env.SERVER_PORT, () => {
  console.log(`Servidor está em execução na porta ${process.env.SERVER_PORT}`);
});

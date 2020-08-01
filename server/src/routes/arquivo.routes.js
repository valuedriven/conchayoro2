module.exports = app => {
    const arquivos = require("../controllers/arquivo.controller.js");
  
    var router = require("express").Router();
    
    router.get("/", arquivos.get);

    router.get("/listar", arquivos.listarArquivos);

    router.get("/:key", arquivos.getArquivo);

    app.use('/api/arquivos', router);
  };


const db = require("../models");
const Produto = db.produtos;
const Op = db.Sequelize.Op;

exports.create = (req, res) => {
    // Validate request
    console.log(req.body);
    if (!req.body.nome) {
      res.status(400).send({
        message: "Content can not be empty!"
      });
      return;
    }
  
    const produto = {
      nome: req.body.nome,
      unidade: req.body.unidade,
      tipoProduto: req.body.tipoProduto,
      precoUnitario: req.body.precoUnitario
    };
  
    Produto.create(produto)
      .then(data => {
        res.send(data);
      })
      .catch(err => {
        res.status(500).send({
          message:
            err.message || "Some error occurred while creating the Produto."
        });
      });
};


exports.findAll = (req, res) => {
    const nome = req.query.nome;
    var condition = nome ? { nome: { [Op.iLike]: `%${nome}%` } } : null;
  
    Produto.findAll({ where: condition })
      .then(data => {
        res.send(data);
      })
      .catch(err => {
        res.status(500).send({
          message:
            err.message || "Some error occurred while retrieving Produtos."
        });
      });
  };

// Find a single Produto with an id
exports.findOne = (req, res) => {
  const id = req.params.id;

  Produto.findByPk(id)
    .then(data => {
      res.send(data);
    })
    .catch(err => {
      res.status(500).send({
        message: "Error retrieving Produto with id=" + id
      });
    });
};

// Update a Produto by the id in the request
exports.update = (req, res) => {
    const id = req.params.id;
  
    Produto.update(req.body, {
      where: { id: id }
    })
      .then(num => {
        if (num == 1) {
          res.send({
            message: "Produto was updated successfully."
          });
        } else {
          res.send({
            message: `Cannot update Produto with id=${id}. Maybe Produto was not found or req.body is empty!`
          });
        }
      })
      .catch(err => {
        res.status(500).send({
          message: "Error updating Produto with id=" + id
        });
      });
  };

// Delete a Produto with the specified id in the request
exports.delete = (req, res) => {
    const id = req.params.id;
  
    Produto.destroy({
      where: { id: id }
    })
      .then(num => {
        if (num == 1) {
          res.send({
            message: "Produto was deleted successfully!"
          });
        } else {
          res.send({
            message: `Cannot delete Produto with id=${id}. Maybe Produto was not found!`
          });
        }
      })
      .catch(err => {
        res.status(500).send({
          message: "Could not delete Produto with id=" + id
        });
      });
  };

exports.deleteAll = (req, res) => {
    Produto.destroy({
      where: {},
      truncate: false
    })
      .then(nums => {
        res.send({ message: `${nums} Produtos were deleted successfully!` });
      })
      .catch(err => {
        res.status(500).send({
          message:
            err.message || "Some error occurred while removing all Produtos."
        });
    });
};

exports.findAllPublished = (req, res) => {
    Produto.findAll({ where: { published: true } })
      .then(data => {
        res.send(data);
      })
      .catch(err => {
        res.status(500).send({
          message:
            err.message || "Some error occurred while retrieving Produtos."
        });
      });
  };
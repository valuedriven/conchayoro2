const Model = Sequelize.Model;
class User extends Model {}
User.init({

  nome: {
    type: Sequelize.STRING,
    allowNull: false
  },
  usuario: {
    type: Sequelize.STRING
  },
  senha: {
    type: Sequelize.STRING
  }
}, {
  sequelize,
  modelName: 'usuario'
});
const envpath = process.env.NODE_ENV === undefined  ? '.env.development' : `.env.${process.env.NODE_ENV}`;

require('dotenv').config({  
  path: envpath
})

module.exports = {

    devServer: {      
      host: process.env.NODE_ENV === 'production' ? '' : process.env.VUE_APP_HOST,
      port: process.env.NODE_ENV === 'production' ? '' : process.env.VUE_APP_PORT,
      https: false,
      hotOnly: false,
    },

  }
console.log('ecoysstem.config.js');

module.exports = {
  apps: [{
    name: 'client',
    script: "./node_modules/@vue/cli-service/bin/vue-cli-service.js",
    args: "serve",
    env: {
      "NODE_ENV": "development",
      "VUE_APP_HOST": 'localhost',
      "VUE_APP_PORT": '3010',
      "VUE_APP_SERVER_HOST": '0.0.0.0',
      "VUE_APP_SERVER_PORT": '3000',
    }
  }]
};

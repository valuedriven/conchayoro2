const env = process.env.NODE_ENV || 'dev';

const dev = { 
    server: {
        host: process.env.DEV_APP_HOST || 'localhost',
        port: parseInt(process.env.DEV_APP_PORT) || 3000
    }
};

const test = {
    server: {
        host: process.env.TEST_APP_HOST || 'localhost',
        port: parseInt(process.env.TEST_APP_PORT) || 3000
    }
};

const config = {
    dev,
    test
};

module.exports = config[env];
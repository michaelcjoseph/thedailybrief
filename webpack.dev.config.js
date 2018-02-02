var webpack = require('webpack'),
config = require('./webpack.config.js');

config.devtool = 'eval';

config.plugins.push(
  new webpack.DefinePlugin({
    'process.env': {
      'NODE_ENV': JSON.stringify('development')
    }
  })
);

module.exports = config;
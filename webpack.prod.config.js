var webpack = require('webpack'),
config = require('./webpack.config.js');

config.devtool = 'cheap-module-source-map';

config.plugins.push(
  new webpack.NoErrorsPlugin(),
  new webpack.optimize.DedupePlugin(),
  new webpack.optimize.OccurrenceOrderPlugin(),
  new webpack.optimize.LimitChunkCountPlugin({maxChunks: 15}),
  new webpack.optimize.MinChunkSizePlugin({minChunkSize: 10000}),

  new webpack.optimize.UglifyJsPlugin({
    compress: {
      warnings: false,
      screw_ie8: true
    },
    comments: false
  }),

  new webpack.DefinePlugin({
    'process.env': {
      'NODE_ENV': JSON.stringify('production')
    }
  })
);

module.exports = config;
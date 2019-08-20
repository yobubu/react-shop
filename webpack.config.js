'use strict';

module.exports = {
    mode: 'production',
    module: {
        rules: [{
            test: /\.js$/,
            exclude: /node_modules|web_modules/,
            use: [{
                loader: 'babel-loader'
            }]
        }]
    },
    devServer: {
        host: '0.0.0.0'
    }
};
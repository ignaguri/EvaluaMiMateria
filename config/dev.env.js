'use strict'
const merge = require('webpack-merge')
const prodEnv = require('./prod.env')

module.exports = merge(prodEnv, {
  NODE_ENV: '"development"',
  API_URL: '"http://localhost/~iguri/AppEncuestadoraCreatividad/"' // para Mac
  // API_URL: '"http://localhost/encuestaVueWebpack/"' // para Win
})

let path = require('path')
const root = path.join(__dirname, 'public')
module.exports = {
  entry: "./src/app.js",
  output: {
    path: root,           //where bundled file will exist
    filename: 'bundle.js' //name of file that gets bundled
  },
  module: {
    rules: [{
      loader: 'babel-loader', //run this
      test: /\.js$/,          //on every js file
      exclude: /node_modules/ //but not those found in node_modules
    },
    {
      use: [
        'style-loader', //dump contents into DOM
        'css-loader',   //read file in
        'sass-loader'
      ],
      test: /\.s?css$/
    }]
  },
  devtool: 'cheap-module-eval-source-map', 
  devServer: {
    contentBase: root //uses bundle.js from memory
  }
}
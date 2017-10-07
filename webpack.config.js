var path = require('path');
// var process = require('process');

module.exports = {
	
	entry: './main.js',
	output: {
		filename: 'bundle.js',
		path: path.resolve(__dirname + '/dist')
	},

	module: {
		rules: [
			{
				test: /\.html$/,
				exclude: /node_modules/,
				loader: 'file-loader?name=[name].[ext]'
			},
			{
				test: /\.elm$/,
				exclude: [/elm-stuff/, /node_modules/],
				loader: 'elm-webpack-loader?verbose=true'
			}
		],

		noParse: /\.elm$/
	},

	devServer: {
		inline: true,
		stats: { colors: true },
		port: 3000
	},

	devtool:  "eval-source-map"
};

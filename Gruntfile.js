module.exports = function(grunt) {

	var fs = require('fs'),
		poly = require('@babel/polyfill');

	require('jit-grunt')(grunt);

	var LessPluginAutoPrefix = require('less-plugin-autoprefix'),
	autoprefixPlugin = new LessPluginAutoPrefix({browsers: ["last 2 versions"]});

	grunt.initConfig({
		/* babel: {
			options: {
				sourceMap: true,
				presets: [
					['@babel/preset-env',
						{ useBuiltIns: "entry" } // this is the polyfill
					],
					[require.resolve('babel-preset-minify'), {
						mangle: false,
						deadcode: false,
						simplify: false,
						evaluate: false,
					}]
				],
				comments: false
			},
			dist: {
				files: {
					'assets/layout/_global/js/global.min.js': 'assets/layout/_global/js/global.js'
				}
			}
		},
		eslint: {
				target: ['javascripts/src/zenu.js']
		}, */
		less: {
			'style.less': {
				options: {
					plugins: [
						autoprefixPlugin
					],
					sourceMap: true,
					sourceMapRootpath:'/',
					compress: true,
					yuicompress: true,
					optimization: 2
				},
				files: {
					'stylesheets/css/res.css': 'stylesheets/less/res.less',
					'stylesheets/css/rur.css': 'stylesheets/less/rur.less',
					'stylesheets/css/bus.css': 'stylesheets/less/bus.less',
					'stylesheets/css/hol.css': 'stylesheets/less/hol.less'
				}
			}
		},
		watch: {
			styles: {
				files: ['stylesheets/**/*.less'],
				tasks: ['less'],
				options: {
					spawn: false
				}
			}
			/*,
			babel: {
				files: ['javascripts/src/zenu.js'], // which files to watch
				tasks: ['eslint','babel'],
				options: {
					spawn: false
				}
			}*/
		},
	});

	grunt.registerTask('default', ['watch'])

};
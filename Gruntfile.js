module.exports = function(grunt) {
    "use strict";

    var maybeBanner = '/* Maybe v' + grunt.file.readJSON('package.json').version + ' */';

    grunt.initConfig({

        pkg: grunt.file.readJSON('package.json'),

        coffee: {
            build: {
                files: {
                    'dist/maybe.js': ['lib/*.coffee']
                }
            },
            tests: {
                options: {
                    bare: true
                },
                files: {
                    'spec/maybe.spec.js': ['tests/maybe.spec.coffee']
                }
            }
        },

        uglify: {
            dist: {
                files: {
                    'dist/maybe.min.js': ['dist/maybe.js']
                }
            }
        },

        concat: {
            dev: {
                options: { banner: maybeBanner + "\r\n" },
                src: 'dist/maybe.js',
                dest: 'dist/maybe.js'
            },
            prod: {
                options: { banner: maybeBanner },
                src: 'dist/maybe.min.js',
                dest: 'dist/maybe.min.js'
            }
        },

        jasmine: {
            src: 'dist/maybe.js',
            options: {
                specs: 'spec/*spec.js'
            }
        }
    });

    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-concat');
    grunt.loadNpmTasks('grunt-contrib-jasmine');

    grunt.registerTask('default', ['test']);
    grunt.registerTask('build', ['coffee', 'uglify', 'concat']);
    grunt.registerTask('test', ['build', 'jasmine'])
};
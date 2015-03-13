module.exports = function (grunt) {
    grunt.loadNpmTasks('grunt-bower');
    grunt.loadNpmTasks('grunt-contrib-clean');
    grunt.loadNpmTasks('grunt-contrib-concat');
    grunt.loadNpmTasks('grunt-contrib-connect');
    grunt.loadNpmTasks('grunt-contrib-copy');
    grunt.loadNpmTasks('grunt-contrib-htmlmin');
    grunt.loadNpmTasks('grunt-contrib-less');
    grunt.loadNpmTasks('grunt-contrib-uglify');
    grunt.loadNpmTasks('grunt-contrib-watch');

    // Project configuration.
    grunt.initConfig({
        clean: ['tmp', 'dist'],
        bower: {
            dev: {
                dest: 'dist/libs',
                options: {
                    expand: true
                }
            }
        },
        copy: {
            dist: {
                files: [
                    {
                        expand: true,
                        cwd: 'tmp/appjs',
                        src: ['**/*.js'],
                        dest: 'dist/assets/js'
                    }
                ]
            }
        },
        concat: {
            appjs: {
                src: ['src/assets/js/*.js'],
                dest: 'tmp/appjs/app.js'
            }
        },
        htmlmin: {
            build: {
                options: {
                    removeComments: true,
                    collapseWhitespace: true
                },
                files: [
                    {
                        expand: true,
                        cwd: 'src',
                        src: ['**/*.html'],
                        dest: 'dist'}
                ]
            }
        },
        cssmin: {
            build: {
                files: [
                    {
                        expand: true,
                        cwd: 'src/assets/css',
                        src: ['*.css'],
                        dest: 'dist/assets/css',
                        ext: '.css'}
                ]
            }
        },
        less: {
            build: {
                options: {
                    paths: ['src/assets/less'],
                    compress: true,
                    optimization: 3
                },
                files: [
                    {
                        expand: true,
                        cwd: 'src/assets/less',
                        src: ['*.less'],
                        dest: 'dist/assets/css',
                        ext: '.css'
                    }
                ]
            }
        },
        uglify: {
            dist: {
                options: {
                    compress: false,
                    beautiful: true
                },
                files: [
                    {
                        expand: true,
                        cwd: 'tmp/appjs/',
                        src: ['**/*.js'],
                        dest: 'dist/assets/js'
                    }
                ]
            }
        },
        connect: {
            server: {
                options: {
                    port: 9000,
                    base: "dist",
                    hostname: "localhost",
                    livereload: true,
                    open: true
                }
            }
        },
        watch: {
            options: {
                livereload: true
            },
            html: {
                files: "src/**/*.html",
                tasks: ["htmlmin"]
            },
            js: {
                files: "src/**/*.js",
                tasks: ["concat","uglify"]
            },
            css: {
                files: "src/**/*.css",
                tasks: ["cssmin"]
            },
            less: {
                files: "src/**/*.less",
                tasks: ["less"]
            }
        }

    });

    grunt.registerTask('build', ['bower', 'concat','uglify', 'less', 'htmlmin', 'connect', 'watch']);
    grunt.registerTask('default', ['build']);
};

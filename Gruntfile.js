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
    grunt.loadNpmTasks('grunt-war');

    // Project configuration.
    grunt.initConfig({
        clean: ['tmp', 'dist', 'war'],
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
                dest: 'tmp/appjs/*.js'
            }
        },
        htmlmin: {
            build: {
                options: {
                    removeComments: true,
                    collapseWhitespace: true
                },
                files: [
                    {expand: true, cwd: 'src', src: ['**/*.html'], dest: 'dist'}
                ]
            }
        },
        cssmin: {
            build: {
                files: [
                    {
                        expand: true, cwd: 'src/assets/css',
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
                        cwd: 'src/assets/js',
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
                tasks: ["uglify"]
            },
            css: {
                files: "src/**/*.css",
                tasks: ["cssmin"]
            },
            less: {
                files: "src/**/*.less",
                tasks: ["less"]
            }
        },
        war: {
            target: {
                options: {
                    war_dist_folder: 'war',
                    war_name: 'app-icon-material',
                    webxml_webapp_version: '2.5',
                    webxml_webapp_xmlns: 'http://java.sun.com/xml/ns/javaee',
                    webxml_webapp_xmlns_xsi: 'http://www.w3.org/2001/XMLSchema-instance',
                    webxml_webapp_xsi_schema_location: 'http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd'
                },
                files: [
                    {
                        expand: true,
                        cwd: 'dist',
                        src: ['**'],
                        dest: ''
                    }
                ]
            }
        }
    });

    grunt.registerTask('build', ['bower', 'uglify', 'less', 'htmlmin', 'connect', 'watch']);
    grunt.registerTask('default', ['build']);
};

[1mdiff --git a/.gitignore b/.gitignore[m
[1mindex 14bc68c..9772727 100644[m
[1m--- a/.gitignore[m
[1m+++ b/.gitignore[m
[36m@@ -1 +1,8 @@[m
[31m-/nbproject/private/[m
\ No newline at end of file[m
[32m+[m[32m/nbproject/[m
[32m+[m[32m/nbproject/private/[m
[32m+[m[32m/bower_components/[m
[32m+[m[32m/bower_components/*[m
[32m+[m[32m/node_modules/[m
[32m+[m[32m/node_modules/*[m
[32m+[m[32m/tmp/[m
[32m+[m[32m/tmp/*[m
[1mdiff --git a/Gruntfile.js b/Gruntfile.js[m
[1mindex 8ead5e9..f401a5f 100644[m
[1m--- a/Gruntfile.js[m
[1m+++ b/Gruntfile.js[m
[36m@@ -8,11 +8,10 @@[m [mmodule.exports = function (grunt) {[m
     grunt.loadNpmTasks('grunt-contrib-less');[m
     grunt.loadNpmTasks('grunt-contrib-uglify');[m
     grunt.loadNpmTasks('grunt-contrib-watch');[m
[31m-    grunt.loadNpmTasks('grunt-war');[m
 [m
     // Project configuration.[m
     grunt.initConfig({[m
[31m-        clean: ['tmp', 'dist', 'war'],[m
[32m+[m[32m        clean: ['tmp', 'dist'],[m
         bower: {[m
             dev: {[m
                 dest: 'dist/libs',[m
[36m@@ -24,7 +23,7 @@[m [mmodule.exports = function (grunt) {[m
         copy: {[m
             dist: {[m
                 files: [[m
[31m-                     {[m
[32m+[m[32m                    {[m
                         expand: true,[m
                         cwd: 'tmp/appjs',[m
                         src: ['**/*.js'],[m
[36m@@ -36,7 +35,7 @@[m [mmodule.exports = function (grunt) {[m
         concat: {[m
             appjs: {[m
                 src: ['src/assets/js/*.js'],[m
[31m-                dest: 'tmp/appjs/*.js'[m
[32m+[m[32m                dest: 'tmp/appjs/app.js'[m
             }[m
         },[m
         htmlmin: {[m
[36m@@ -46,7 +45,11 @@[m [mmodule.exports = function (grunt) {[m
                     collapseWhitespace: true[m
                 },[m
                 files: [[m
[31m-                    {expand: true, cwd: 'src', src: ['**/*.html'], dest: 'dist'}[m
[32m+[m[32m                    {[m
[32m+[m[32m                        expand: true,[m
[32m+[m[32m                        cwd: 'src',[m
[32m+[m[32m                        src: ['**/*.html'],[m
[32m+[m[32m                        dest: 'dist'}[m
                 ][m
             }[m
         },[m
[36m@@ -54,7 +57,8 @@[m [mmodule.exports = function (grunt) {[m
             build: {[m
                 files: [[m
                     {[m
[31m-                        expand: true, cwd: 'src/assets/css',[m
[32m+[m[32m                        expand: true,[m
[32m+[m[32m                        cwd: 'src/assets/css',[m
                         src: ['*.css'],[m
                         dest: 'dist/assets/css',[m
                         ext: '.css'}[m
[36m@@ -82,14 +86,13 @@[m [mmodule.exports = function (grunt) {[m
         uglify: {[m
             dist: {[m
                 options: {[m
[31m-[m
                     compress: false,[m
                     beautiful: true[m
                 },[m
                 files: [[m
                     {[m
                         expand: true,[m
[31m-                        cwd: 'src/assets/js',[m
[32m+[m[32m                        cwd: 'tmp/appjs/',[m
                         src: ['**/*.js'],[m
                         dest: 'dist/assets/js'[m
                     }[m
[36m@@ -117,7 +120,7 @@[m [mmodule.exports = function (grunt) {[m
             },[m
             js: {[m
                 files: "src/**/*.js",[m
[31m-                tasks: ["uglify"][m
[32m+[m[32m                tasks: ["concat","uglify"][m
             },[m
             css: {[m
                 files: "src/**/*.css",[m
[36m@@ -127,29 +130,10 @@[m [mmodule.exports = function (grunt) {[m
                 files: "src/**/*.less",[m
                 tasks: ["less"][m
             }[m
[31m-        },[m
[31m-        war: {[m
[31m-            target: {[m
[31m-                options: {[m
[31m-                    war_dist_folder: 'war',[m
[31m-                    war_name: 'app-icon-material',[m
[31m-                    webxml_webapp_version: '2.5',[m
[31m-                    webxml_webapp_xmlns: 'http://java.sun.com/xml/ns/javaee',[m
[31m-                    webxml_webapp_xmlns_xsi: 'http://www.w3.org/2001/XMLSchema-instance',[m
[31m-                    webxml_webapp_xsi_schema_location: 'http://java.sun.com/xml/ns/javaee http://java.sun.com/xml/ns/javaee/web-app_2_5.xsd'[m
[31m-                },[m
[31m-                files: [[m
[31m-                    {[m
[31m-                        expand: true,[m
[31m-                        cwd: 'dist',[m
[31m-                        src: ['**'],[m
[31m-                        dest: ''[m
[31m-                    }[m
[31m-                ][m
[31m-            }[m
         }[m
[32m+[m
     });[m
 [m
[31m-    grunt.registerTask('build', ['bower', 'uglify', 'less', 'htmlmin', 'connect', 'watch']);[m
[32m+[m[32m    grunt.registerTask('build', ['bower', 'concat','uglify', 'less', 'htmlmin', 'connect', 'watch']);[m
     grunt.registerTask('default', ['build']);[m
 };[m
[1mdiff --git a/bower.json b/bower.json[m
[1mindex cb17e6e..d8e235e 100644[m
[1m--- a/bower.json[m
[1m+++ b/bower.json[m
[36m@@ -3,6 +3,7 @@[m
     "version": "0.0.1",[m
     "dependencies": {[m
         "angular": "latest",[m
[32m+[m[32m        "bootstrap": "latest",[m
         "bootstrap-material-design": "latest"[m
     }[m
 }[m
\ No newline at end of file[m
[1mdiff --git a/src/index.html b/src/index.html[m
[1mindex 5fba9fd..993130f 100644[m
[1m--- a/src/index.html[m
[1m+++ b/src/index.html[m
[36m@@ -1,808 +1,64 @@[m
 <!DOCTYPE html>[m
 <html>[m
[31m-  <head>[m
[31m-      <title>App icons Material</title>[m
[32m+[m[32m    <head>[m
[32m+[m[32m        <title>App icons Material</title>[m
[32m+[m[32m        <!--[if lt IE 9]>[m
[32m+[m[32m          <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>[m
[32m+[m[32m          <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>[m
 [m
[31m-    <!--METAS-->[m
[31m-    <meta charset="utf-8">[m
[31m-    <meta http-equiv="X-UA-Compatible" content="IE=edge">[m
[31m-    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">[m
[32m+[m[32m          <script type="text/javascript" src="http://css3-mediaqueries-js.googlecode.com/svn/trunk/css3-mediaqueries.js"></script>[m
[32m+[m[32m          <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/selectivizr/1.0.2/selectivizr-min.js"></script>[m
[32m+[m[32m        <![endif]-->[m
 [m
[31m-    <!-- CSS --> [m
[31m-    <link href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" rel="stylesheet" type="text/css" />[m
[31m-    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">[m
[31m-    <link href="https://rawgit.com/FezVrasta/bootstrap-material-design/master/dist/css/material-wfont.min.css" rel="stylesheet" type="text/css" />    [m
[31m-    <link href="https://rawgit.com/FezVrasta/bootstrap-material-design/master/dist/css/material.css" rel="stylesheet" type="text/css" />[m
[31m-    <link href="https://rawgit.com/FezVrasta/bootstrap-material-design/master/dist/css/ripples.min.css" rel="stylesheet" type="text/css" />[m
[31m-    [m
[31m-    [m
[31m-    <!-- SCRIPTS --> [m
[31m-    <script src="http://code.jquery.com/jquery.min.js"></script>[m
[31m-    <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>[m
[31m-    <script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.3.2/angular.min.js"></script>[m
[31m-    [m
[31m-    <!-- Calço HTML5 e Respond.js para apoio IE8 de elementos HTML5 e consultas de mídia ->[m
[31m-<!-- AVISO: A Respond.js não funcionar se você visualizar a página via file: // ->[m
[31m-    <!--[if lt IE 9]>[m
[31m-      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>[m
[31m-      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>[m
[32m+[m[32m        <!--METAS-->[m
[32m+[m[32m        <meta charset="utf-8">[m
[32m+[m[32m        <meta http-equiv="X-UA-Compatible" content="IE=edge">[m
[32m+[m[32m        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-size=1, user-scalable=no">[m
 [m
[31m-      <script type="text/javascript" src="http://css3-mediaqueries-js.googlecode.com/svn/trunk/css3-mediaqueries.js"></script>[m
[31m-      <script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/selectivizr/1.0.2/selectivizr-min.js"></script>[m
[31m-    <![endif]-->[m
[31m-    [m
[32m+[m[32m        <!-- CSS -->[m
[32m+[m[32m        <link href="libs/bootstrap/dist/css/bootstrap.css" rel="stylesheet" type="text/css" />[m
[32m+[m[32m        <link href="libs/bootstrap-material-design/dist/css/material.css" rel="stylesheet" type="text/css" />[m
[32m+[m[32m        <link href="libs/bootstrap-material-design/dist/css/ripples.css" rel="stylesheet" type="text/css" />[m
 [m
[32m+[m[32m        <!-- SCRIPTS -->[m
[32m+[m[32m        <script src="libs/jquery/dist/jquery.js"></script>[m
[32m+[m[32m        <script src="libs/bootstrap/dist/js/bootstrap.js"></script>[m
[32m+[m[32m        <script src="libs/angular/angular.js"></script>[m
[32m+[m[32m        <script src="assets/js/app.js"></script>[m
 [m
[31m-  </head>[m
[31m-  <body ng-app="icones" ng-controller="iconesCtrl">[m
[31m-     <div class="container">[m
[31m-      <div class="row">[m
[31m-        [m
[31m-       <div class="panel panel-primary">[m
[31m-          <div class="panel-heading">[m
[31m-              <h3 class="panel-title">Search icon:</h3>[m
[31m-          </div>[m
[31m-          <div class="panel-body">[m
[31m-            [m
[31m-          <input type="type" class="form-control" id="filtro" placeholder="categoria-descricao" ng-model="filtro">[m
[31m-      </div>[m
[31m-          [m
[31m-      </div>[m
[31m-       [m
[31m-         <div class="list-group">[m
[31m-          <div class="list-group-item col-sm-6" ng-repeat="icon in icones| filter:filtro" >[m
[31m-              <div class="row-action-primary">[m
[31m-                  <i class="mdi{{icon}}"></i>[m
[31m-              </div>[m
[31m-              <div class="row-content">[m
[31m-                  <h4 class="list-group-item-heading">mdi{{icon}}</h4>[m
[31m-                  <p class="list-group-item-text">class="mdi{{icon}}"</p>[m
[31m-              </div>[m
[31m-          </div>[m
[31m-       [m
[31m-       </div>[m
[31m-       [m
[31m-       [m
[31m-       [m
[31m-    </div>    [m
[31m-    <!-- Faça seus testes aqui jovem -->[m
[31m-    <script src="https://rawgit.com/FezVrasta/bootstrap-material-design/master/dist/js/material.min.js"></script>[m
[31m-    <script src="https://rawgit.com/FezVrasta/bootstrap-material-design/master/dist/js/ripples.min.js"></script>[m
[31m-    [m
[31m-  <script id="jsbin-javascript">[m
[31m-var icones = angular.module("icones",[]);[m
[31m-icones.controller("iconesCtrl",['$scope',function($scope){[m
[31m-  $scope.icones = ["-action-3d-rotation","-action-accessibility","-action-account-balance","-action-account-balance-wallet","-action-account-box",[m
[31m-"-action-account-child","-action-account-circle","-action-add-shopping-cart",[m
[31m-"-action-alarm","-action-alarm-add","-action-alarm-off","-action-alarm-on","-action-android","-action-announcement",[m
[31m-"-action-aspect-ratio",[m
[31m-"-action-assessment",[m
[31m-"-action-assignment",[m
[31m-"-action-assignment-ind",[m
[31m-"-action-assignment-late",[m
[31m-"-action-assignment-return",[m
[31m-"-action-assignment-returned",[m
[31m-"-action-assignment-turned-in",[m
[31m-"-action-autorenew",[m
[31m-"-action-backup",[m
[31m-"-action-book",[m
[31m-"-action-bookmark",[m
[31m-"-action-bookmark-outline",[m
[31m-"-action-bug-report",[m
[31m-"-action-cached",[m
[31m-"-action-class",[m
[31m-"-action-credit-card",[m
[31m-"-action-dashboard",[m
[31m-"-action-delete",[m
[31m-"-action-description",[m
[31m-"-action-dns",[m
[31m-"-action-done",[m
[31m-"-action-done-all",[m
[31m-"-action-event",[m
[31m-"-action-exit-to-app",[m
[31m-"-action-explore",[m
[31m-"-action-extension",[m
[31m-"-action-face-unlock",[m
[31m-"-action-favorite",[m
[31m-"-action-favorite-outline",[m
[31m-"-action-find-in-page",[m
[31m-"-action-find-replace",[m
[31m-"-action-flip-to-back",[m
[31m-"-action-flip-to-front",[m
[31m-"-action-get-app",[m
[31m-"-action-grade",[m
[31m-"-action-group-work",[m
[31m-"-action-help",[m
[31m-"-action-highlight-remove",[m
[31m-"-action-history",[m
[31m-"-action-home",[m
[31m-"-action-https",[m
[31m-"-action-info",[m
[31m-"-action-info-outline",[m
[31m-"-action-input",[m
[31m-"-action-invert-colors",[m
[31m-"-action-label",[m
[31m-"-action-label-outline",[m
[31m-"-action-language",[m
[31m-"-action-launch",[m
[31m-"-action-list",[m
[31m-"-action-lock",[m
[31m-"-action-lock-open",[m
[31m-"-action-lock-outline",[m
[31m-"-action-loyalty",[m
[31m-"-action-markunread-mailbox",[m
[31m-"-action-note-add",[m
[31m-"-action-open-in-browser",[m
[31m-"-action-open-in-new",[m
[31m-"-action-open-with",[m
[31m-"-action-pageview",[m
[31m-"-action-payment",[m
[31m-"-action-perm-camera-mic",[m
[31m-"-action-perm-contact-cal",[m
[31m-"-action-perm-data-setting",[m
[31m-"-action-perm-device-info",[m
[31m-"-action-perm-identity",[m
[31m-"-action-perm-media",[m
[31m-"-action-perm-phone-msg",[m
[31m-"-action-perm-scan-wifi",[m
[31m-"-action-picture-in-picture",[m
[31m-"-action-polymer",[m
[31m-"-action-print",[m
[31m-"-action-query-builder",[m
[31m-"-action-question-answer",[m
[31m-"-action-receipt",[m
[31m-"-action-redeem",[m
[31m-"-action-report-problem",[m
[31m-"-action-restore",[m
[31m-"-action-room",[m
[31m-"-action-schedule",[m
[31m-"-action-search",[m
[31m-"-action-settings",[m
[31m-"-action-settings-applications",[m
[31m-"-action-settings-backup-restore",[m
[31m-"-action-settings-bluetooth",[m
[31m-"-action-settings-cell",[m
[31m-"-action-settings-display",[m
[31m-"-action-settings-ethernet",[m
[31m-"-action-settings-input-antenna",[m
[31m-"-action-settings-input-component",[m
[31m-"-action-settings-input-composite",[m
[31m-"-action-settings-input-hdmi",[m
[31m-"-action-settings-input-svideo",[m
[31m-"-action-settings-overscan",[m
[31m-"-action-settings-phone",[m
[31m-"-action-settings-power",[m
[31m-"-action-settings-remote",[m
[31m-"-action-settings-voice",[m
[31m-"-action-shop",[m
[31m-"-action-shop-two",[m
[31m-"-action-shopping-basket",[m
[31m-"-action-shopping-cart",[m
[31m-"-action-speaker-notes",[m
[31m-"-action-spellcheck",[m
[31m-"-action-star-rate",[m
[31m-"-action-stars",[m
[31m-"-action-store",[m
[31m-"-action-subject",[m
[31m-"-action-swap-horiz",[m
[31m-"-action-swap-vert",[m
[31m-"-action-swap-vert-circle",[m
[31m-"-action-system-update-tv",[m
[31m-"-action-tab",[m
[31m-"-action-tab-unselected",[m
[31m-"-action-theaters",[m
[31m-"-action-thumb-down",[m
[31m-"-action-thumb-up",[m
[31m-"-action-thumbs-up-down",[m
[31m-"-action-toc",[m
[31m-"-action-today",[m
[31m-"-action-track-changes",[m
[31m-"-action-translate",[m
[31m-"-action-trending-down",[m
[31m-"-action-trending-neutral",[m
[31m-"-action-trending-up",[m
[31m-"-action-turned-in",[m
[31m-"-action-turned-in-not",[m
[31m-"-action-verified-user",[m
[31m-"-action-view-agenda",[m
[31m-"-action-view-array",[m
[31m-"-action-view-carousel",[m
[31m-"-action-view-column",[m
[31m-"-action-view-day",[m
[31m-"-action-view-headline",[m
[31m-"-action-view-list",[m
[31m-"-action-view-module",[m
[31m-"-action-view-quilt",[m
[31m-"-action-view-stream",[m
[31m-"-action-view-week",[m
[31m-"-action-visibility",[m
[31m-"-action-visibility-off",[m
[31m-
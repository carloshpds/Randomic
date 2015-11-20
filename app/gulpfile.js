'use strict';

var gulp   = require('gulp');

/*
  ==========================
  Basic Options
  ==========================
*/
var options = {
  mainAngularModule : 'RandomicApp',

  wiredep: {
    exclude: [
      /bootstrap-sass-official\/.*\.js/,
      /bootstrap\.css/,
      'bower_components/angular-input-masks',
      /angulartics-/
    ]
  }
};


/*
  ==========================
  Base build
  ==========================
*/

options.modulesData = {
  proxy: {
    isEnabled: false
  }
}

/*
  ==========================
  Read gulp files
  ==========================
*/
require('basebuild-angular')(options);


/*
  ==========================
  Default Task
  ==========================
*/
gulp.task('default', ['clean'], function () {
    gulp.start('build');
});

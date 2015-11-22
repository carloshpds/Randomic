'use strict';

var gulp   = require('gulp');
var gutil  = require('gulp-util');
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
  },

  unitTests : {
    testAutoConfig: {
      suppressCoverage: gutil.env['suppress-coverage'] || gutil.env['suppressCoverage']
    }
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

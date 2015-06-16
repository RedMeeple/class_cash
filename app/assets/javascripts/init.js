$(function () {
  'use strict';
  
  if ($('.student-list').length) {
    app.students.tableRichest();
  }
  
  if ($('.student-show-container').length) {
    app.students.individualRichest();
  }
  
  
});
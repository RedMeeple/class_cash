$(function () {
  'use strict';
  
  if ($('.student-table').length) {
    app.students.tableRichest();
  }
  
  if ($('.student-show-container').length) {
    app.students.individualRichest();
  }
  
  if ($('.welcome-container').length || $('.login-container').length) {
    $('.navigation').remove();
  }
  
  
  
  $('.menu-btn').click(function () {
    $('.menu-responsive').toggleClass('expand');
  });
});
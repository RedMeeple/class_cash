$(function () {
  'use strict';
  
  if ($('.student-table').length) {
    app.students.tableRichest();
    app.navbar.tableStudents();
  }
  
  if ($('.student-show-container').length) {
    app.students.individualRichest();
    app.navbar.showStudent();
  }
  
  if ($('.welcome-container').length || $('.login-container').length) {
    app.navbar.removeBurger();
  }
  
  app.navbar.hamburger();
  
  
});
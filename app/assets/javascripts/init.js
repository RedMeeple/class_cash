$(function () {
  'use strict';
  
  app.navbar.hamburger();
  
  if ($('.welcome-container').length || $('.login-container').length) {
    app.navbar.removeBurger();
  }
  
  if ($('.student-table').length) {
    var uL = $('.menu-responsive ul');
    
    app.navbar.homeLink(uL);
    app.navbar.newStudentLink(uL);
    
    app.students.tableRichest();
  }
  
  if ($('.student-show-container').length) {
    var uL = $('.menu-responsive ul');
    
    app.navbar.homeLink(uL);
    app.navbar.editStudentLink(uL);
    
    app.students.individualRichest();
  }
  
  if ($('.students-new-title').length) {
    var uL = $('.menu-responsive ul');
    
    app.navbar.homeLink(uL);
  }
  
});
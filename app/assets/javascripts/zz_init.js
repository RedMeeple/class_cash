$(function () {
  'use strict';

  if ($('.student-table').length) {
    app.students.tableRichest();

    app.students.tableBehavior();
    
    app.students.displayOptions();
  }

  if ($('.student-show-container').length) {
    var uL = $('.menu-responsive ul');

    // app.navbar.homeLink(uL);
    app.navbar.editStudentLink(uL);

    app.students.individualRichest();
  }

  if ($('.students-new-title').length) {
    var uL = $('.menu-responsive ul');

    app.navbar.homeLink(uL);
  }
  
  if ($('.period-title-container').length) {
    app.periods.tableRichest();
  }

  // input section stuff
  $('.login-input-box').focusin(function() {
    $(this).siblings('span').addClass('focus-in');
  });

  $('.login-input-box').focusout(function() {
    var characters = $(this).val();
    if (characters === '') {
    $(this).siblings('span').removeClass('focus-in');
  }
  });


});

$(function () {
  'use strict';

  if ($('.student-table').length) {

    app.students.displayOptions();
  }

  if ($('.student-show-container').length) {
    var uL = $('.menu-responsive ul');

    // app.navbar.homeLink(uL);
    app.navbar.editStudentLink(uL);
  }

  if ($('.students-new-title').length) {
    var uL = $('.menu-responsive ul');

    app.navbar.homeLink(uL);
  }

  if ($('.periods-table').length) {
    app.periods.displayPeriodsOptions();
  }

  if ($('.period-table-info').length) {
    app.periods.displayPeriodOptions();
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

//Awards Modal
  $('.display-class-bonus-modal').click(function() {
    $('.class-bonus-modal-container').slideDown();
    $('.class-bonus-modal-header').slideDown();
    $('.class-bonus-modal').fadeIn(1000);
    $('.close-btn').fadeIn();
  });

  $('.close-btn').click(function() {
    $(this).parent().parent().slideUp();
    $('.class-bonus-modal-header').slideUp();
    $(this).fadeOut();
    $('.class-bonus-modal').fadeOut('fast');
  });


});

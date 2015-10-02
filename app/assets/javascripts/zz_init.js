$(function () {
  'use strict';

  app.periods.togglePeriod();

  app.application.navBar();

  if ($('.student-table').length) {

    app.students.displayOptions();
  }

  if ($('.roster-title').length) {
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
    $('.class-modal').fadeIn('fast');
  });

//Bonus Modal
  $('.display-bonus-modal').click(function() {
    $('.ind-modal').fadeIn('fast');
  });

//Student Dropdown
  $('.student-transaction-heading').click(function() {
    $(this).next().slideToggle();
    $(this).find('.student-transaction-dropdown').toggleClass('rotate-dropdown');
  });

// Rights

  $('.rights-main-container').on('click', '.right-dropdown', function() {
    $(this).closest('div').find('div.right-list').slideToggle();
    $(this).toggleClass('right-dropdown-rotate');
  })


//Default Modal
  $('.view-modal-btn').click(function() {
    $(this).next().fadeIn('fast');
  });

  $('.modal-close').click(function() {
    $('.main-modal-container').fadeOut('fast');
    $('.modal').fadeOut('fast');
  });

  $('.new-loan-btn').click(function() {
    $('.new-loan-modal').fadeIn('fast');
  });

  $('.transfer-money-modal-btn').click(function() {
    $('.modal').fadeIn('fast');
  });

//New Student Modal
  $('.new-student-modal-btn').click(function() {
    $('.student-modal').fadeIn('fast');
  });

//Hire Student Modal
  $('.hire-modal-btn').click(function() {
    $('.hire-modal').fadeIn('fast');
  });

//Give Award Modal
  $('.give-award-btn').click(function() {
    $('.give-award-modal').fadeIn('fast');
  });

//Teacher Transfer Money Modal
  $('.transaction-modal-btn').click(function() {
    $('.transaction-modal').fadeIn('fast');
  });

//Close modal by clicking outside of it
  $('.outer-modal-click').click(function() {
    $(this).parent().fadeOut('fast');
  });

//Store item modal
  $('.item-modal-btn').click(function() {
    $('.item-modal').fadeIn('fast');
  });

  $('.instant-purchase-modal-btn').click(function() {
    $('.instant-purchase-modal').fadeIn('fast');
  });

});

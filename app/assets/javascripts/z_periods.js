 // Place all the behaviors and hooks related to the matching controller here.
 // All this logic will automatically be available in application.js.

app.periods = {

  displayPeriodsOptions: function () {
    $('.periods-table-info-options div').on('click', function () {
      
      $('.periods-table-info-options div').removeClass('active');

      $(this).next().toggleClass('active');
    });
  },

  displayPeriodOptions: function () {
    $('.period-table-info-options div').on('click', function () {
      
      $('.period-table-info-options div').removeClass('active');

      $(this).next().toggleClass('active');
    });
  }
}

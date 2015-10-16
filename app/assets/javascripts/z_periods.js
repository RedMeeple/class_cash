 // Place all the behaviors and hooks related to the matching controller here.
 // All this logic will automatically be available in application.js.

app.periods = {

  displayPeriodsOptions: function () {
    $('.buttons-container').on('click', 'div.pure-button', function () {

      if ($(this).next().hasClass('active')) {
        $(this).next().toggleClass('active');
      } else {
        $('.periods-table-info-options-list').removeClass('active');
        $('.period-table-info-options-list').removeClass('active');
        $(this).next().toggleClass('active');
      }

    });
  },

  displayPeriodOptions: function () {
    $('.period-table-container').on('click', '.pure-button',function () {

      if ($(this).next().hasClass('active')) {
        $(this).next().toggleClass('active');
      } else {
        $('.period-table-info-options-list').removeClass('active');
        $('.periods-table-info-options-list').removeClass('active');
        $(this).next().toggleClass('active');
      }

    });
  },

  togglePeriod: function () {
    $('.period-info-heading').on('click', function () {
      id = this.id;
      $('#period-table-container-' + id).slideToggle('slow');
    });
  }


}
